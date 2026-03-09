<?php

$redis = new Redis();
$redis->connect('redis-service', 6379);

$cacheKey = "welcome_message";

echo "<h1 style='text-align:center;margin-top:20%;font-family:Arial'>";

if ($redis->exists($cacheKey)) {

    $message = $redis->get($cacheKey);

    echo "Welcome Syed Shahabuddin Quadri<br>";
    echo $message."<br>";
    echo "<span style='color:green'>Response from Redis Cache 🚀</span>";

} else {

    $dbResponse = "My PHP DevOps Application is Running in Kubernetes with Redis Cache";

    $redis->set($cacheKey, $dbResponse);

    echo "Welcome Syed Shahabuddin<br>";
    echo $dbResponse."<br>";
    echo "<span style='color:red'>Response from MySQL Database</span>";

}

echo "</h1>";

?>