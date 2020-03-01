#from which image in docker hub we want to build the image up
FROM jboss/wildfly:10.1.0.Final

#add from internet or copy from local
#add library from internet of database to the image
ADD https://downloads.mariadb.com/Connectors/java/connector-java-1.5.9/mariadb-java-client-1.5.9.jar /opt/jboss/wildfly/modules/system/layers/base/org/mariadb/jdbc/main/

#copy library folder from local to the database that we add
COPY librerias/module.xml /opt/jboss/wildfly/modules/system/layers/base/org/mariadb/jdbc/main/

#to put our app in the image
ADD aplicacion/Aplicacion.war /opt/jboss/wildfly/standalone/deployments/

#execute commands linux
#give admin permission and password
RUN /opt/jboss/wildfly/bin/add-user.sh admin victor1 --silent

#exponer puerto
#los contenedores tienen que tener puertos para acceder a ellos
EXPOSE 9990

#exponer ciertas carpetas del contenedor a la maquina para que pueda acceder
VOLUME /opt/jboss/wildfly/standalone/deployments/

#usually Dockerfile is executed as root, this is not appropiate
USER jboss

#cambiar el arranque de ese servidor contenedor (ENTRYPOINT o CMD)
#ENTRYPOINT es la forma de entrada al servicio y luego puedes pasar parametros por CMD
#CMD puede arrancar completamente el servicio
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
