
CAROOT_CONF_FILES	= \
    root/openssl.cnf \
    intermediate/openssl.cnf

#dist_caroot_DATA	= $(CAROOT_CONF_FILES)    

SBIN_FILES		=			\
	create_new_server_cert.sh			

dist_sbin_SCRIPTS	= $(SBIN_FILES)

ROOT_KEY_FILE=$(DESTDIR)$(carootdir)/root/private/ca.key.pem
ROOT_KEY_PASS=$(DESTDIR)$(carootdir)/root/private/pass
ROOT_CSR_FILE=$(DESTDIR)$(carootdir)/root/csr/ca.csr.pem
ROOT_CERT_FILE=$(DESTDIR)$(carootdir)/root/certs/ca.cert.pem
ROOT_SSL_CONF=$(DESTDIR)$(carootdir)/root/openssl.cnf
INTERMEDIATE_KEY_FILE=$(DESTDIR)$(carootdir)/intermediate/private/intermediate.key.pem
INTERMEDIATE_KEY_PASS=$(DESTDIR)$(carootdir)/intermediate/private/pass
INTERMEDIATE_CSR_FILE=$(DESTDIR)$(carootdir)/intermediate/csr/intermediate.csr.pem
INTERMEDIATE_CERT_FILE=$(DESTDIR)$(carootdir)/intermediate/certs/intermediate.cert.pem
INTERMEDIATE_SSL_CONF=$(DESTDIR)$(carootdir)/intermediate/openssl.cnf
CA_CHAIN_CERT_FILE=$(DESTDIR)$(carootdir)/intermediate/certs/ca-chain.cert.pem
SUBJECT_PREFIX=/C=@CERT_COUNTRY@/ST=@CERT_STATE@/L=@CERT_LOCALITY@/organizationName=@CERT_ORG@/OU=@CERT_ORG_UNIT@/CN=


install-data-local:
	rm -rf $(DESTDIR)$(carootdir)/root
	rm -rf $(DESTDIR)$(carootdir)/intermediate
	$(MKDIR_P) $(DESTDIR)$(carootdir)/root/private
	$(MKDIR_P) $(DESTDIR)$(carootdir)/root/csr
	$(MKDIR_P) $(DESTDIR)$(carootdir)/root/certs
	$(MKDIR_P) $(DESTDIR)$(carootdir)/root/newcerts
	$(MKDIR_P) $(DESTDIR)$(carootdir)/intermediate/private
	$(MKDIR_P) $(DESTDIR)$(carootdir)/intermediate/csr
	$(MKDIR_P) $(DESTDIR)$(carootdir)/intermediate/certs
	$(MKDIR_P) $(DESTDIR)$(carootdir)/intermediate/newcerts	
	chmod 700 $(DESTDIR)$(carootdir)/root/private
	touch $(DESTDIR)$(carootdir)/root/index.txt
	echo 1000 > $(DESTDIR)$(carootdir)/root/serial
	chmod 700 $(DESTDIR)$(carootdir)/intermediate/private
	touch $(DESTDIR)$(carootdir)/intermediate/index.txt
	echo 1000 > $(DESTDIR)$(carootdir)/intermediate/serial
	echo 1000 > $(DESTDIR)$(carootdir)/intermediate/crlnumber
	cp -apv root/openssl.cnf $(ROOT_SSL_CONF)
	cp -apv intermediate/openssl.cnf $(INTERMEDIATE_SSL_CONF)
	echo
	echo "Create the password for the root private key: $(ROOT_KEY_PASS)"
	cat /dev/urandom | tr -dc 'a-zA-Z0-9@#$%^&*' | fold -w 32 | head -n 1 > $(ROOT_KEY_PASS)
	chmod 400 $(ROOT_KEY_PASS)
	echo
	echo "Creating private key: $(ROOT_KEY_FILE)"
	openssl genrsa -aes256 -out $(ROOT_KEY_FILE) \
	        -passout file:$(ROOT_KEY_PASS) 4096
	chmod 400 $(ROOT_KEY_FILE)
	echo
	echo "Creating root cert with subject: $(SUBJECT_PREFIX)ca_root"
	echo
	openssl req -config "$(ROOT_SSL_CONF)" \
	      -key "$(ROOT_KEY_FILE)" \
	      -passin "file:$(ROOT_KEY_PASS)" \
	      -subj "$(SUBJECT_PREFIX)ca_root" \
	      -new -x509 -days 7300 -sha256 -extensions v3_ca \
	      -out "$(ROOT_CERT_FILE)"
	chmod 444 "$(ROOT_CERT_FILE)"
	openssl x509 -noout -text -in "$(ROOT_CERT_FILE)"    
	echo
	echo "Create the password for the intermediate private key $(INTERMEDIATE_KEY_PASS)"
	cat /dev/urandom | tr -dc 'a-zA-Z0-9@#$%^&*' | fold -w 32 | head -n 1 > $(INTERMEDIATE_KEY_PASS)
	chmod 400 $(INTERMEDIATE_KEY_PASS)
	echo
	echo "Creating private key: $(INTERMEDIATE_KEY_FILE)"
	openssl genrsa -aes256 -out $(INTERMEDIATE_KEY_FILE) \
	        -passout file:$(INTERMEDIATE_KEY_PASS) 4096
	chmod 400 $(INTERMEDIATE_KEY_FILE)
	echo
	echo "Creating intermediate csr with subject: $(SUBJECT_PREFIX)ca_intermediate"
	openssl req -config "$(INTERMEDIATE_SSL_CONF)" \
	      -key "$(INTERMEDIATE_KEY_FILE)" \
	      -passin "file:$(INTERMEDIATE_KEY_PASS)" \
	      -subj "$(SUBJECT_PREFIX)ca_intermediate" \
	      -new -sha256 \
	      -out "$(INTERMEDIATE_CSR_FILE)"
	echo
	echo "Creating intermediate cert by signing with the root cert"
	openssl ca -verbose -config "$(ROOT_SSL_CONF)" -extensions v3_intermediate_ca \
	      -keyfile "$(ROOT_KEY_FILE)" \
	      -passin "file:$(ROOT_KEY_PASS)" \
	      -days 3650 -notext -md sha256 -batch \
	      -in "$(INTERMEDIATE_CSR_FILE)" \
	      -out "$(INTERMEDIATE_CERT_FILE)" 
	chmod 444 "$(INTERMEDIATE_CERT_FILE)"
	openssl x509 -noout -text -in "$(INTERMEDIATE_CERT_FILE)"    
	openssl verify -CAfile "$(ROOT_CERT_FILE)" "$(INTERMEDIATE_CERT_FILE)"
	echo
	echo "Creating certificate chain"
	cat "$(INTERMEDIATE_CERT_FILE)" "$(ROOT_CERT_FILE)" > "$(CA_CHAIN_CERT_FILE)"
	chmod 444 "$(CA_CHAIN_CERT_FILE)"