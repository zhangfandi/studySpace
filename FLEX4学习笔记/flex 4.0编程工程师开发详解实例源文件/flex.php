<?PHP
echo "<root>\n";
for($i = 0; $i < 100; $i++){
	$name = randomName();
	$age = rand(20,60);
	$gender = rand(0,1);
	echo "<person><name>$name</name><age>$age</age><gender>$gender</gender></person>\n";
}
echo '</root>';

function randomName(){
	$name = '';
	for($i = rand(5,8); $i > 0; $i--){
		$name .= chr(rand(97,122));
	}

	return $name;
}
?>
