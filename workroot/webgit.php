<?php
$Config = array(
	'd672302ba9ef2ab9' => array(
		'title' => 'Dwebkit',
		'pwd' => '/home/dev/test/DWebKit',
	),
);

$logPath = '/home/dev/test/githook/log';



date_default_timezone_set('PRC');
$post_data = json_decode(file_get_contents("php://input"), 1);

function doJob($token){
	Global $Config,$logPath;
	$pwd = $Config[$token]['pwd'];
	$command = 'cd ' . str_replace('\\', '/', str_replace(' ', '\ ', $pwd)) . ' && git pull 2>&1';
	$status = shell_exec($command);
	$con = date('Y-m-d H:i:s') . " - {$Config[$token]['title']}\n";
	$dirName = date('ymd');
	file_put_contents($logPath . '/' . $dirName . '.log', $con . json_encode($post_data) . "\n{$status}\n--------------------------\n", FILE_APPEND);
}


if ($post_data && array_key_exists('token', $post_data) && array_key_exists($post_data['token'], $Config)) {
	doJob($post_data['token']);
}else{
	if ($_GET && array_key_exists('t', $_GET) && array_key_exists($_GET['t'], $Config)) {
		doJob($_GET['t']);
	}
}