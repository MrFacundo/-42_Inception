<?php
// router.php
if (preg_match('/^\/adminer/', $_SERVER['REQUEST_URI'])) {
	include_once 'adminer.php';
} else {
	return false;
}