FROM cassandra:3.11
   # override default disabled user defined functions
RUN sed -i -r 's/enable_user_defined_functions: false/enable_user_defined_functions: true/' /etc/cassandra/cassandra.yaml