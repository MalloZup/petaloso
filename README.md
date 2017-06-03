# petaloso
cucumber web-testing tutorial

# Prequisites:

## INSTALL terraform
https://github.com/moio/sumaform/#installation


# HOWTO:

```console
git clone https://github.com/MalloZup/petaloso.git
cd terraform
```
1) **Adapt/create libvirt Network and Prefix in petaloso.tf** (vi petaloso.tf)  (https://github.com/moio/sumaform/tree/master/modules/libvirt#first-time-configuration)

```console
vi petaloso.tf
terraform get
terraform apply
```

RUN the test
```console
scp -r cucumber-tests root@malloZUPcontroller.tf.local:/root
ssh -t root@malloZUPcontroller.tf.local "cd /root/cucumber-tests/ ; rake"
```

### See the results
```console
scp root@malloZUPcontroller.tf.local:/root/cucumber-tests/output.html .
firefox output.html
```



#### Troubleshooting
https://github.com/moio/sumaform/blob/master/TROUBLESHOOTING.md

#### TIPPS 

Don't run the controller in a docker container, you will have ram issues and bugs on your tests.

###### what mean petaloso:
http://www.bbc.com/news/blogs-trending-35653871
