<?php 
require_once("../config.inc.php");
require_once("../libs/functions.inc.php");
require_once("../libs/smarty/Smarty.class.php");

$smarty = new Smarty();
$smarty->compile_check = true;
$smarty->template_dir = "../templates";
$smarty->compile_dir = "../tmp";

$share = isset($_GET['share']) 	? $_GET['share']: -1;
$path = isset($_GET['path']) 	? $_GET['path']."/" : "";
$id = isset($_GET['id']) 		? $_GET['id'] 	: null;
$page = isset($_GET['page']) 	? $_GET['page'] : 0;

$id = ($id === null) ? $page * PAGE_SIZE : $id;
$smarty->assign('id', $id);

if ( $share === -1 ) {	
	$smarty->assign('shares', $shares);
	$content = $smarty->fetch('base.tpl');
	$smarty->assign('background', 'base');
}
else {
	$smarty->assign('share_name', $shares[$share]['name']);
	$smarty->assign('share_id', $share);
	$smarty->assign('share_icon', $shares[$share]['icon']);
	$smarty->assign('path', $path);
	$smarty->assign('page', $page);
	
	$played = open_played();

	$files = array();
	$directories = array();
	
	foreach($shares[$share]["paths"] as $p) {
		if ( ($dir = realpath($p['local']."/".$path)) !== false ) {		
			foreach(scandir($dir) as $file) {
				if ( $file == "." || $file == ".." )
					continue;
				
				if ( is_file($dir."/".$file) ) {
					if ( ($type = get_type(strtolower(pathinfo($dir."/".$file, PATHINFO_EXTENSION)))) !== false ) {
						$files[] = array(					
							'filename' => $file,
							'pch_file' => PCH_BASE.$p['pch']."/".$path.$file,
							'local_file' => $dir."/".$file,
							'played' => in_array(get_file_hash($dir."/".$file), $played),
							'type' => $type
						);
					}
				} 
				elseif (is_dir($dir."/".$file)) {
					$directories[] = array(
						'path' => $file,
						'full_path' => $path.$file,
					);
				}
			}
		}
	}
	$smarty->assign('pages', ceil((count($directories) + count($files))/PAGE_SIZE));	
	$smarty->assign('total', count($directories) + count($files));
	
	sort_dirs_files($directories, $files);
	split_dirs_files($directories, $files, $page);	
	reorder_dirs_files($directories, $files, $page);	

	$count = count($directories) + count($files);
	
	$smarty->assign('directories', $directories);
	$smarty->assign('files', $files);	
	$smarty->assign('count', $count);
	$smarty->assign('rest', (PAGE_SIZE-$count > 0) ? range(1, PAGE_SIZE - $count) : array() );	
	$content = $smarty->fetch('share.tpl');
	
	$smarty->assign('background', 'share');
}

$smarty->assignByRef( 'content', $content );
$smarty->display('layout.tpl');
exit;
?>
