# Wallet Web

## Requirements

* walletd with container
* PHP 7
* Composer

### Installation

```bash
# install script
composer install

# run daemon
./niobiod

# generate container
./walletd --daemon-port=8314 --container-file=vini --container-password=123456 --generate-container

# run container with daemon
./walletd --daemon-port=8314 --container-file=vini --container-password=123456 --daemon

# Enjoy

```

### Methods

```php
<?php

require_once 'vendor/autoload.php';

$client = new \Niobio\JsonRPCClient('http://localhost:8070');


var_dump($client->getBalance());
var_dump($client->getAddresses());
```

### TODO

#### Create new methods
http://forknote.net/documentation/rpc-wallet/rpc-wallet-curl-examples/#rpc-wallet-curl-examples