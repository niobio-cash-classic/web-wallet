<?php

namespace Niobio;

use GuzzleHttp\Client;

class JsonRPCClient
{
    /**
     * @var string
     */
    private $url;

    private $notification = false;

    public function __construct(string $endPoint)
    {
        $this->url = $endPoint;
    }

    public function setRPCNotification(bool $notification): void
    {
        $this->notification = $notification;
    }

    /**
     * @param string $method
     * @param array $params
     * @return \stdClass
     */
    public function __call(string $method, array $params = []): \stdClass
    {
        $request = [
            'jsonrpc' => '2.0',
            'method' => $method,
            'params' => $params,
        ];

        $special = ['send_transaction', 'get_transaction', 'transfer',];

        if (\in_array($method, $special, true)) {
            $request = str_replace(array('[', ']'), '', htmlspecialchars(json_encode($request), ENT_NOQUOTES));

            if (preg_match("/\"destinations\":{/i", $request)) {
                $request = str_replace("\"destinations\":{", "\"destinations\":[{", $request);
                $request = str_replace("},\"payment", "}],\"payment", $request);
            }
        } else {
            $request = json_encode($request, JSON_FORCE_OBJECT);
        }

        $http = new Client([
            'base_uri' => $this->url,
        ]);

        $response = $http->post('/json_rpc', ['body' => $request]);

        return json_decode($response->getBody()->getContents());
    }
}
