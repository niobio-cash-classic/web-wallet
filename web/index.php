<?php

require_once '../vendor/autoload.php';

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

$container = new \League\Container\Container();

$container->share('response', Zend\Diactoros\Response::class);
$container->share('request', function () {
    return Zend\Diactoros\ServerRequestFactory::fromGlobals(
        $_SERVER, $_GET, $_POST, $_COOKIE, $_FILES
    );
});

$container->share('emitter', Zend\Diactoros\Response\SapiEmitter::class);

$route = new League\Route\RouteCollection($container);
$view = new League\Plates\Engine(__DIR__ .'/../templates');

$route->map('GET', '/', function (ServerRequestInterface $request, ResponseInterface $response) use ($view) {
     $response->getBody()->write($view->render('home'));

     return $response;
});

$route->map('GET', '/create', function (ServerRequestInterface $request, ResponseInterface $response) use ($view) {
    $key = 'NBR' . mb_substr(str_shuffle('ABCDEFGHIJKLMKOPQRSTUVXZ1234567890'), 0, 32);


    $response->getBody()->write($view->render('create', ['key' => $key,]));

    return $response;
});

$response = $route->dispatch($container->get('request'), $container->get('response'));

$container->get('emitter')->emit($response);
