# petaloso
cucumber web-testing tutorial

# Prequisites:

* libvirtd up and running with a network default
* terraform

## INSTALL terraform
https://github.com/moio/sumaform/#installation

For libvirt, you can take a look here:
https://github.com/moio/sumaform/blob/master/modules/libvirt/README.md

# HOWTO:

## Create controller with terraform

The controller has all the pkg and will run the driver for webbrowser.

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


## RUN the test

**mallZUP** is only a unique prefix here, you should put something else, your prefix with terraform.
```console
scp -r cucumber-tests root@malloZUPcontroller.tf.local:/root
ssh -t root@malloZUPcontroller.tf.local "cd /root/cucumber-tests/ ; rake"
```

### See the results
```console
scp root@malloZUPcontroller.tf.local:/root/cucumber-tests/output.html .
firefox output.html
```

## How to expand this template

Add your feature to hello.yml, the feature will be executed sequentially
```console
echo "- features/lasagne.feature" >> cucumber-tests/run_sets/hello.yml
touch cucumber-tests/features/lasagne.feature
echo "SOMENEW_TEST" > cucumber-tests/features/lasagne.feature
```

## If you want to change the set of feature.

```console
vi cucumber-tests/run_sets/production.yml
```
Put your features

And..
Modify the Rakefile,

```console
task :cucumber do |t|
  Rake::Task['cucumber:production'].invoke
```


#### Troubleshooting
https://github.com/moio/sumaform/blob/master/TROUBLESHOOTING.md

#### TIPPS 

Don't run the controller in a docker container, you will have ram issues and bugs on your tests.

###### what mean petaloso:
http://www.bbc.com/news/blogs-trending-35653871
