module citytella.core.Entity;

/* Entity class.
   An entity is a base component of the game.

   It has only an ID (primarily for network identification), a name and a 
   3D position.

*/

/* Define a base position */
struct Pos3D {
    double x, y, z, w = 1.0;

    this(double x, double y, double z) {
	this.x = x;
	this.y = y;
	this.z = z;
    }

    
};


/* Defines an abstract entity */
abstract class Entity {
private:
    int _id;
    string _name;
    Pos3D _pos;

public:
    /* Creates an entity.
       Since entities can't be instantiated (for safety), this
       function will create the code for do it */
    void create(int id, string name, Pos3D position) {
	_id = id;
	_name = name;
	_pos = position;
    }

    @property int ID() { return _id; }

    @property string name() { return _name; }
    @property void name(string val) { _name = val; }

    @property Pos3D position() { return _pos; }
    @property void position(Pos3D val) { _pos = val; }

    abstract void iterate();
};
