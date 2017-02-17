
import std.stdio;
import citytella.core.Entity;
import citytella.core.EntityManager;

class ConcreteEntity : Entity {

public:
    this(int id, Pos3D pos) {
	super.create(id, "Concrete Entity", pos);
	EntityManager.getEntityManager().addEntity(super);
    }

    override void iterate() {
	writeln("hello");
    }

};

int main(string[] args)
{
    writeln("Hi");

    ConcreteEntity c = new ConcreteEntity(1, Pos3D(1.0, 0.6, 2.8));
    writefln(" -> ConcreteEntity: [id: %d, name: %s, pos: (%.2f, %.2f, %.2f)}",
	     c.ID, c.name, c.position.x, c.position.y, c.position.z);
    writefln("Entity with id 1 is %s",
	     EntityManager.getEntityManager().getEntity(1).name);


    for (int i = 0; i < 10; i++) {
	EntityManager.getEntityManager().iterate();
    }

    c.name = "New Entity";

    writefln("Now it's %s", EntityManager.getEntityManager().getEntity(1).name);
    
    EntityManager.getEntityManager().removeEntity(1);

    try {
	EntityManager.getEntityManager().getEntity(1);
    } catch (Exception e) {
	writefln("Error: %s", e.msg);
    }        	
    
    return 0;
}
