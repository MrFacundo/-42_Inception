<?php
// router.php
if ($_SERVER['REQUEST_URI'] == '/adminer') {
	include_once 'adminer.php';
} else {
	return false;
}