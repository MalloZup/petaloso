# petaloso
cucumber web-testing tutorial

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
scp cucumber-tests root@yourprefixcontroller.tf.local:/root
ssh root@yourprefixcontroller.tf.local "cd /root/cucumber-tests/ ; rake"
```

#### Troubleshooting
https://github.com/moio/sumaform/blob/master/TROUBLESHOOTING.md

#### TIPPS 

Don't run the controller in a docker container, you will have ram issues and bugs on your tests.

###### what mean petaloso:
http://www.bbc.com/news/blogs-trending-35653871
