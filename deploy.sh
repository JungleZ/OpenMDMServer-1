#!/bin/bash  -ilex
# deploy.sh xxx

#BUILD_ID = DONTKILLME
#. /etc/profile
#
#
#
#export $PROJ_PATH = `pwd`
#
#echo "project path is : $PROJ_PATH"
#
#export $TOMCAT_APP_PATH = "/usr/local/src/tomcat"
#
#echo "tomcat path is : $TOMCAT_APP_PATH"
#
#sh $PROJ_PATH/OpenMDMServer/deploy.sh

killTomcat()
{
	pid=`ps -ef | grep tomcat |grep java | awk '{print $2}'`
	echo "tomcat Id list $pid"
	if ["$pid" = ""]
	then 
	   echo "no tomcat pid alive "
	else 
	   kill -9 $pid
	fi
}
cd $PROJ_PATH/OpenMDMServer
mvn clean install
killTomcat

#删除原有工程

#rm -rf $TOMCAT_APP_PATH/webapps/ROOT
rm -rf $TOMCAT_APP_PATH/webapps/ROOT.war
rm -rf $TOMCAT_APP_PATH/webapps/OpenMDMServer.war
rm -rf $TOMCAT_APP_PATH/webapps/OpenMDMServer
rm -rf $TOMCAT_APP_PATH/webapps/docs
rm -rf $TOMCAT_APP_PATH/webapps/examples
rm -rf $TOMCAT_APP_PATH/webapps/host-manager
rm -rf $TOMCAT_APP_PATH/webapps/manager
rm -rf $TOMCAT_APP_PATH/webapps/ROOT
#复制新的工程
cp -r $PROJ_PATH/OpenMDMServer/target/OpenMDMServer-1.0.war $TOMCAT_APP_PATH/webapps/

echo "from  $PROJ_PATH/OpenMDMServer to $TOMCAT_APP_PATH/webapps/"

cd $TOMCAT_APP_PATH/webapps

echo "before  $TOMCAT_APP_PATH/webapps/OpenMDMServer to $TOMCAT_APP_PATH/webapps/ROOT "
mv OpenMDMServer-1.0.war ROOT.war

rm -rf $TOMCAT_APP_PATH/webapps/OpenMDMServer-1.0.war

echo "after $TOMCAT_APP_PATH/webapps/OpenMDMServer to $TOMCAT_APP_PATH/webapps/ROOT "

echo "set up success"
#启动tomcat 
cd $TOMCAT_APP_PATH/
sh bin/startup.sh
