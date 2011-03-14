<?php
require_once("../config.inc.php");

function directory_sort($a, $b) {	
	return strcmp($a['path'], $b['path']);
}

function file_sort($a, $b) {
	return strcmp($a['filename'], $b['filename']);
}

function sort_dirs_files(&$directories, &$files) {
	uasort($directories, 'directory_sort');
	uasort($files, 'file_sort');
	$directories = array_values($directories);	
}

function split_dirs_files(&$directories, &$files, $page) {
	$count = count($directories);
	$directories = array_splice($directories, $page * PAGE_SIZE, PAGE_SIZE);
	$page_count = count($directories);
		
	if ( $page_count >= PAGE_SIZE ) {
		$files = array();
	}

	if ( $page_count < PAGE_SIZE ) {
		$offset = ($page > 0) ? ($page * PAGE_SIZE) - $count : 0;
		$size = PAGE_SIZE - $page_count;
		
		$files = array_splice($files, $offset, $size);
	}
}

function reorder_dirs_files(&$directories, &$files, $page) {	
	$start = $page * PAGE_SIZE;
	
	$tmp = $directories;
	$directories = array();	
	
	foreach($tmp as $t)
		$directories[$start++] = $t;
	
	$tmp = $files;
	$files = array();
	
	foreach($tmp as $t)
		$files[$start++] = $t;
}

function open_played() {
	if ( !file_exists(PLAYED_FILE) )
		touch(PLAYED_FILE);

	return file(PLAYED_FILE, FILE_SKIP_EMPTY_LINES | FILE_IGNORE_NEW_LINES);
}

function check_played($file) {
	$played = open_played();
	return in_array($file, $played);
}

function get_file_hash($file) {
	list(,,,,,,,$size) = stat($file);
	return sha1(basename($file).$size);
}

function get_type($ext) {
	global $types;
	foreach($types as $type => $extensions) 
		if ( in_array($ext, $extensions) )
			return $type;
			
	return false;
}

function add_played($file) {
	$hash = get_file_hash($file);
	
	if ( !check_played($hash) ) {
		$h = fopen(PLAYED_FILE, "a");
		fwrite($h, $hash."\n");
		fclose($h);
	}
}

function remove_played($file) {
	$hash = get_file_hash($file);
	
	if ( check_played($hash) ) {
		$data = array_diff(open_played(), array($hash));
		$h = fopen(PLAYED_FILE, "w");
		fwrite($h, implode("\n",$data)."\n");
		fclose($h);
	}
}

function get_mediainfo($file) {
	
	$mediainfo = simplexml_load_string(shell_exec("/usr/bin/mediainfo --Output=XML \"{$file}\""));
	
	$duration = $mediainfo->File->track[0]->Duration;
	
	return array(
		'duration' => $duration
	);
}
