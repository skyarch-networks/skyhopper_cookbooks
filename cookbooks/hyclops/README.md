Description
===========

This cookbook is the cookbook for HyClops for Zabbix installation.
"HyClops for Zabbix" is Zabbix extension that provide some features to management Amazon EC2 and VMware vSphere on Zabbix.

GitHub repository: https://github.com/tech-sketch/HyClops.git
Official Site: http://tech-sketch.github.io/hyclops

Requirements
============

Supported OS:

* CentOS5-6
* Ubuntu11-13
* Amazon Linux

Tested Chef version: 11.4.4

Dependent cookbooks:

* python
* yum
* build-essential
* zabbix

Attributes
==========

### Settings about HyClops Server

* default['hyclops']['version']
    * Set version number which you want to install.
    * (default settings)'0.2.0'
* default['hyclops']['source_url']
    * (default settings)'https://github.com/tech-sketch/hyclops/archive/(version).tar.gz'
* default['hyclops']['install_dir']
    * Set hyclops install base directory path.
    * (default settings)'/opt/hyclops'
* default['hyclops']['download_path']
    * Set hyclops download path.
    * (default settings)'/tmp/hyclops'
* default['hyclops']['server']
    * Set hyclops server IP address/hostname.
    * (default settings)'127.0.0.1'
* default['hyclops']['port']
    * Set hyclops listen port number.
    * (default settings)'5555'
* default['hyclops']['log_level']
    * Set log level.(DEBUG, INFORMATION, WARNING, ERROR)
    *(default settings)'WARNING'
* default['hyclops']['log_file']
    * Set log file path. This log file must be given write permission from hyclops & httpd user.
    * (default settings)'/opt/hyclops/logs/hyclops_server.log'

### Settings about Zabbix Server

* default['zabbix']['frontend_url']
    * Set Zabbix Frontend URL. This setting is used by accessing Zabbix API.
    * (default settings)"http://#{default['zabbix']['server']['host']}/zabbix"

### Settings about GateOne

* default['gateone']['url']
    * Set GateOne server url. If GateOne is running on the other from Zabbix Server, please change this setting.
    * (default settings)"https://#{gateone_public_ip}"
    * gateone.js などが存在するurlを指定する(https)

### Settings about ZeroMQ

Set ZeroMQ package repository URL for CentOS,RHEL,AmazonLinux

* version 5 url: http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-5/home:fengshuo:zeromq.repo
* version 6 url: http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-6/home:fengshuo:zeromq.repo 

* default['zeromq']['repo_url']
    * (default settings)'http://download.opensuse.org/repositories/home:/fengshuo:/zeromq/CentOS_CentOS-6/home:fengshuo:zeromq.repo'

Usage
=====

run_list
---------
* `role[hyclops]`

Security Groups
----------------
defaultを指定

setting
-------------

### 値のマッピング設定
#### `管理 -> 一般設定 -> 値のマッピング`

##### Script return code

| 受信データ | マッピング文字列 |
|------------|------------------|
| 0          | success          |
| 1          | failure          |

##### Libcloud Node State

| 受信データ | マッピング文字列 |
|------------|------------------|
| 0          | running          |
| 1          | rebooting        |
| 2          | terminated       |
| 3          | pending          |
| 4          | stopped          |

### マクロ設定
#### `設定 -> テンプレート -> AWSAccount -> マクロ -> ${VM_TEMPLATES_LINUX}`
AWS から自動的に取得したインスタンスに適用したいテンプレートを指定。

* Template OS Linux など

### ホスト登録
#### `設定 -> ホスト -> Zabbix Server -> テンプレート`

* `HyClops Server`
* `AmazonEC2`
* `GateOne Server`
* `AWSAccount`

をリンク、追加、保存

#### `設定 -> ホスト -> Zabbix Server -> マクロ`
* `${KEY}`
  * AWS の API Key
* `${SECRET}`
  * AWS の API Secret

#### `設定 -> ホスト -> Zabbix Server -> ホスト -> ステータス`
有効に


しばらく待つと ec2 インスタンスの取得、稼働しているインスタンスの数が取得される。


License
======

Copyright 2013 TIS Inc. HyClops for Zabbix Team (hyclops@ml.tis.co.jp)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
