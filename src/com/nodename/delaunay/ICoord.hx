package com.nodename.delaunay;
import openfl.geom.Point;

//import as3.TypeDefs;

interface ICoord {
	public var coord(get_coord, null):Point;
	public function get_coord():Point;
}