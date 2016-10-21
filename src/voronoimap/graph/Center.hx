package voronoimap.graph;
//import as3.TypeDefs;
import de.polygonal.ds.Heapable;
import openfl.display.Sprite;
import haxe.ds.Vector;
import openfl.geom.Point;

import de.polygonal.ds.GraphNode;
import de.polygonal.Printf;

class Center implements Heapable<Center>{
	//public function new() { }
	
	public var index:Int;
  
    public var point:Point;  // location
    public var water:Bool;  // lake or ocean
    public var ocean:Bool;  // ocean
    public var coast:Bool;  // land polygon touching an ocean
    public var border:Bool;  // at the edge of the map
    public var biome:String;  // biome type (see article)
    public var elevation:Float;  // 0.0-1.0
    public var moisture:Float;  // 0.0-1.0

    public var neighbors:Array<Center>;
    public var borders:Array<Edge>;
    public var corners:Array<Corner>;
	
	public var sprite:CenteredSprite;
	
	/**
	 * Cartesian coordinates (by default z=0).
	 */
	public var z:Float;
	
	/** Heapable interface */
	public var position:Int;
	
	/**
	 * The total distance of all the edges that compromise the best path to this node so far.
	 */
	public var distance:Float;
	
	/**
	 * Heuristic estimate of the distance to the target to direct the search towards the target.
	 */
	public var heuristic:Float;
	
	/**
	 * True if this waypoint is contained in the queue.
	 */
	public var onQue:Bool;
	
	/**
	 * The graph node that holds this waypoint.
	 */
	public var node:GraphNode<Center>;
	
	public function new()
	{
		point=new Point();
		
		z = 0;
		position = -1;
		distance = Math.NaN;
		heuristic = Math.NaN;
		onQue = false;
		node = null;
		
		sprite = new CenteredSprite(this);
		sprite.graphics.beginFill(0x00ff001);
		sprite.graphics.drawCircle(0, 0, 10);
		sprite.graphics.endFill();
	}
	
	inline public function reset():Void
	{
		distance = 0;
		heuristic = 0;
		onQue = false;
	}
	
	public function distanceTo(wp:Center):Float
	{
		var dx = wp.point.x - point.x;
		var dy = wp.point.y - point.y;
		var dz = wp.z - z;
		return Math.sqrt(dx * dx + dy * dy + dz * dz);
	}
	
	public function compare(other:Center):Int
	{
		var x = other.heuristic - heuristic;
		return (x > 0.) ? 1 : (x < 0. ? -1 : 0);
	}
	
	public function toString():String
	{
		return Printf.format("{ Center x: %.2f, y: %.2f }", [point.x, point.y]);
	}
	
    
}