/*
	Arguments
	==============================================
	Object stuffingItem:
		- type: 1 = roll, 2 = sheet, 3 = cut size, 4 = cup-stock
		- width
		- height
		- depth
		- positionX
		- positionY
		- positionZ
	Object container:
		- width
		- height
		- depth
	viewType: 1 = 2D top, 2 = 2D side, 3 = 3D
	outputDiv: Where to draw
*/
function drawContainer(container, stuffingItems, viewType, outputDiv){
	
	//Configurable variable
	var objectScaleFactor = 0.01;
	var objectHoriZontalOffset = 1;

	
	//Build rendering objects
	var scene = new THREE.Scene();
	var camera = new THREE.PerspectiveCamera( 60, window.innerWidth/window.innerHeight, 0.1, 1000 );			
	var renderer = new THREE.WebGLRenderer();
	renderer.setSize( outputDiv.offsetWidth, outputDiv.offsetHeight );
	
	outputDiv.appendChild(renderer.domElement);
	
	
	//Draw container wall
	var containerFloor = buildBoxMesh(0x66CCFF, 
								  container.depth * objectScaleFactor, 
								  0.1, 
								  container.width * objectScaleFactor,
								  false);	
	containerFloor.position.set(0,0,0);
	//containerFloor.rotation.x = 0 * (Math.PI / 180);
	scene.add( containerFloor );
	
	var containerWall = buildBoxMesh(0x6699FF, 
								 container.depth * objectScaleFactor, 
								 container.width * objectScaleFactor, 
								 0.1,
								 false);
	containerWall.position.set(0, (container.width * objectScaleFactor)/2, -(container.width * objectScaleFactor)/2);
	scene.add( containerWall );
	
	var containerOriginX = (container.depth * objectScaleFactor)/2;
	var containerOriginY = 0.1/2;
	var containerOriginZ = -(container.width * objectScaleFactor)/2
			
	//For each stuffing items, put into container
	var itemMesh = buildBoxMesh(0xFFFF00, 
							stuffingItems.depth * objectScaleFactor, 
							stuffingItems.height * objectScaleFactor, 
							stuffingItems.width * objectScaleFactor,
							true); 			
	itemMesh.position.set(containerOriginX,
						  (stuffingItems.height * objectScaleFactor)/2,
						  containerOriginZ);
	scene.add( itemMesh );
	
	//Give screen output
	camera.position.z = 100;
	//camera.position.y = 0;
	camera.lookAt( new THREE.Vector3( 0, 0, 0 ) );
	renderer.render(scene, camera);
}
		

function buildBoxMesh(meshColor, width, height, depth, drawAsWireFrame){
	var geometry = new THREE.BoxGeometry( width, height, depth );
	var material = new THREE.MeshBasicMaterial( { color: meshColor, wireframe: drawAsWireFrame } );
	var mesh = new THREE.Mesh( geometry, material );
	return mesh;
}		