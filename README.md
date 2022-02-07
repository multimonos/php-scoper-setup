# PHP Scoper for Wordpres Plugin Setup

This setup can be used to prefix classnames, say for a wordpress plugin.

## Install php-scoper

install globally not within you package.

```bash
composer global require php-scoper --with-all-dependencies
```

## Configure php-scoper

Create the `scoper.inc.php` file

```bash
php-scoper init
```

# Customize the ./scoper.init.php

In my case i have my psr-4 namespaced class in `./lib`, so, I modified `scoper.inc.php`,

```
FIND    -> Finder::create()->files()->in('src'),
REPLACE -> Finder::create()->files()->in('lib'),
```

# Run the scope.sh script

```bash
cd /path/to/project
./scope.sh
```

# Require the new php-scoper autoloader

Instead of requiring `vendor/autoload.php` I include `vendor/scoper-autoload.php` which also includes the standard autoloader.

Option 1)

```php
 require_once __DIR__ . '/vendor/scoper-autoload.php';
```

Option 2) Sometimes you just want to start working without running scoper, so, this works wel for that situation.

```php
// autloading scoped vs. unscoped
if ( file_exists( __DIR__ . '/vendor/scoper-autoload.php' ) ) {
    require_once __DIR__ . '/vendor/scoper-autoload.php';
} else {
    require_once __DIR__ . '/vendor/autoload.php';
}
````

## How to validate that scoper did it's job?

```php
<?php
 $loader = require_once __DIR__ . '/vendor/scoper-autoload.php';
 print_r( $loader->getClassMap() );
 exit;
 ```
