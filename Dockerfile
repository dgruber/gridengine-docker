FROM centos:centos7

RUN yum --enablerepo=extras install -y epel-release

RUN yum update -y
RUN yum install -y 'dnf-command(config-manager)'
RUN yum install -y db4-utils

# centos 7 requires copr
RUN yum -y install yum-plugin-copr

# kudos to loveshack
RUN yum copr enable -y loveshack/SGE

RUN yum install -y hwloc
RUN yum install -y gridengine gridengine-execd gridengine-qmaster gridengine-devel

ADD auto_install_template /opt/sge

ENV SGE_ROOT=/opt/sge

# qmon is required for the installer running through
RUN touch /opt/sge/bin/lx-amd64/qmon

ENV LD_LIBRARY_PATH $SGE_ROOT/lib/lx-amd64

ADD install.sh /opt/sge/install.sh

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
