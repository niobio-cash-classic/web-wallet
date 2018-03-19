<?php

require_once '../vendor/autoload.php';

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use League\Route\RouteCollection;
use League\Plates\Engine as View;
use Symfony\Component\HttpFoundation\Session\Session;

$container = new \League\Container\Container();

$container->share('response', Zend\Diactoros\Response::class);
$container->share('request', function () {
    return Zend\Diactoros\ServerRequestFactory::fromGlobals(
        $_SERVER, $_GET, $_POST, $_COOKIE, $_FILES
    );
});

$container->share('emitter', Zend\Diactoros\Response\SapiEmitter::class);

$route = new RouteCollection($container);
$view = new View(__DIR__ .'/../templates');
$session = new Session();

$route->map('GET', '/', function (ServerRequestInterface $request, ResponseInterface $response) use ($view) {
     $response->getBody()->write($view->render('home'));

     return $response;
});

$route->map('GET', '/create', function (ServerRequestInterface $request, ResponseInterface $response) use ($view) {
    $key = 'NBR' . mb_substr(str_shuffle('ABCDEFGHIJKLMKOPQRSTUVXZ1234567890'), 0, 32);

    $response->getBody()->write($view->render('create', ['key' => $key,]));

    return $response;
});

$route->map('POST', '/create', function (\Zend\Diactoros\ServerRequest $request, ResponseInterface $response) use ($view) {
    $post = $request->getParsedBody();

    return $response;
});

$route->map('GET', '/dashboard', function (ServerRequestInterface $request, ResponseInterface $response) use ($view, $session) {
    $response->getBody()->write($view->render('dash'));

    return $response;
});

$response = $route->dispatch($container->get('request'), $container->get('response'));

$container->get('emitter')->emit($response);

