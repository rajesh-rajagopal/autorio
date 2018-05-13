# autorio

Automated deployment of [Rio/OS](http://rio.digital) using [SSHKit](https://github.com/capistrano/sshkit).


This is an opinionated tool like [ceph-deploy](https://github.com/ceph/ceph-deploy) and not a general purpose devOps tool like [chef](https://chef.io), [Habitat](https://habitat.sh), [Ansible](https://ansible).

Ofcourse recipes in chef, puppet, ansible, habitat can be created as well.

# Pre reqs

- [Ruby 2.5.x](https://ruby-lang.org)
- [sshkit](https://github.com/capistrano/sshkit)
- [rake](https://github.com/ruby/rake)

# Install Rio OS using Autorio

The install instructions require the [Rio/OS private registry](https://registry.rioos.xyz) SSH RSA public CA certicate for accessing the software to be installed.  Contact [sales@rio.company](sales@rio.company) for requesting access to the private registry.

## Clone 

This isn't packaged as `gem` yet. So yeah, a little bit ugly :).

```

git clone https://github.com/rioadvancement/autorio

cd autorio

```

## Config.yaml

This sections differs for each of the site.  Refer [rio.digital/docs](http://bit.ly/rioos_sh_usersguide/installing#plan)  for the configuration parameter explanation.

```

MY_IP_ADDRESS: "192.168.2.47"
version: "2.0.0-rc5"
RIOOS_REPO: "get.rioos.xyz"
RIOOS_REPO_USER: "rioosadmin"
RIOOS_REPO_PASSWORD: "team4rio"
RIOOS_REGISTRY: "registry.rioos.xyz:5000"
RIOOS_HOME: "/var/lib/rioos"
RIOOS_CONFIG_HOME: "/var/lib/rioos/config"
POWERDNS_HOST: "console.rioos.xyz"
POWERDNS_DOMAIN: "rioosbox.com"
API_SERVER: "https://console.rioos.xyz:7443"
WATCH_SERVER: "https://console.rioos.xyz:8443"


```


| Parameter           | Default value                  | **Modify**  |
|---------------------|--------------------------------|-------------|
| version             | 2.0.0-rc5                      | Required    |
| MY_IP_ADDRESS       | 192.168.1.199                  | Required    |
| RIOOS_REPO          | get.rioos.xyz                  | Default     |
| RIOOS_REPO_USER     | rioosadmin                     | Default     |
| RIOOS_REPO_PASSWORD | team4rio                       | Default     |
| RIOOS_REGISTRY      | registry.rioos.xyz:5000        | Default     |
| RIOOS_HOME:         | /var/lib/rioos                 | Default     |
| RIOOS_CONFIG_HOME   | /var/lib/rioos/config          | Default     |
| POWERDNS_HOST       | console.rioos.xyz              | Required    |
| POWERDNS_DOMAIN     | rioosbox.com                   | Required    |
| API_SERVER          | https://console.rioos.xyz:7443 | Required    |
| WATCH_SERVER        | https://console.rioos.xyz:8443 | Required    |

**Modify** the `parameters marked **Required**

**Example**

| Parameter       | Modify examples             | Modify   |
|-----------------|-----------------------------|----------|
| version         | 2.0.0-rc5, 2.0.0-rc6, 2.0.0 | Required |
| MY_IP_ADDRESS   | 192.168.1.188               | Required |
| POWERDNS_HOST   | 192.1681.188                | Required |
| POWERDNS_DOMAIN | rioosbox.com                | Required |
| API_SERVER      | https://192.1681.188:7443   | Required |
| WATCH_SERVER    | https://192.1681.188:8443   | Required |

### Master

Change the details of the master server and the access details. 

**SSH**

```yaml

master:
  107.151.141.124:
    user: "root"
    ssh: "/home/ram/.ssh/id_rsa.pub"

```

**PASSWORD**

The access to the server can be performed using `password` as well.

```yaml

master:
  107.151.141.124:
    user: "root"
    password: "sucker#4punch"

```

Multiple servers can be provided and installed.

```yaml

master:
  107.151.141.124:
    user: "root"
    ssh: "/home/ram/.ssh/id_rsa.pub"
  107.109.141.100:
    user: "root"
    password: "sucker_punch_5"
  106.151.141.124:
    user: "root"
    ssh: "/home/ram/.ssh/id_rsa.pub"
  console.sucker.punch:
    user: "root"
    ssh: "/home/ram/.ssh/id_rsa.pub"   

```

In the above example, `SSH` is attempted as follows.

```

root@107.151.141.124 using /home/ram/.ssh/id_rsa.pub

root@107.109.141.100 using password sucker_punch_5

root@106.151.141.124 using /home/ram/.ssh/id_rsa.pub

root@console.sucker.punch using /home/ram/.ssh/id_rsa.pub

```


### Nodelet

```yaml
nodelet:
  107.152.143.242:
    user: "root"
    ssh: "/home/ram/.ssh/id_rsa.pub"
```

### Storlet

```yaml
storlet:
  107.152.143.242:
    user: "tesstor1"
    ssh: "/home/ram/.ssh/id_rsa.pub"
```

## Commands 

To execute the commands the `config.yaml` is edited and `rioos_registry_ca.crt` is available in `autorio` directory.

## Version

Shows the version you are about to install

```

rake version

```

## Deploy

- Master
- Nodelet
- Storlet

`rake deploy[pre, master/nodelet/storlet]` 

where 

- `pre` is to setup prequesties
- `master/nodelet/storlet` is the type of installation.

```

cd autorio

bundle install 

rake deploy[pre,master]


```

## Gather

Gather the credentials generated in master. This is used by nodelet and storlet to connect with the master.

```

rake gather

```

## Nodelet with CPU

Digitalcloud

```

rake deploy[,nodelet]

```

Containers
```

rake deploy[pre,nodelet]

```


## Storlet 

```

rake deploy[,storlet]

```

# Clean/Rollback

The last two versions including the current can be cleaned. 

```

rake clean[pre,master]


```
## Invalid version

![Invalid](https://github.com/rioadvancement/autorio/blob/master/public/2_0_0.png)


## 2.0.0-rc0

![Clean 2.0.0-rc0](https://github.com/rioadvancement/autorio/blob/master/public/2_0_0_rc0.png)

## 2.0.0

![Clean 2.0.0](https://github.com/rioadvancement/autorio/blob/master/public/2_0_0.png)

## 2.0.1

![Clean 2.0.1](https://github.com/rioadvancement/autorio/blob/master/public/2_0_1.png)

# Rolling back Rio OS

Use clean to revert a lower version.
