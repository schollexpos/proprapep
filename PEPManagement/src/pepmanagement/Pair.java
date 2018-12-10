package pepmanagement;
public class Pair<X, Y> { 
  public final X x; 
  public final Y y; 
  public Pair(X x, Y y) { 
    this.x = x; 
    this.y = y; 
  } 
  
  @Override
  public boolean equals(Object other) {
	  if(other == null) return false;
	  if(other == this) return true;
	  
	  Pair<X,Y> p = (Pair<X,Y>) other;
	  return x.equals(p.x) && y.equals(p.y);
  }
  
  @Override
  public int hashCode() {
      int result = 17;
      result = 31 * result + x.hashCode();
      result = 31 * result + y.hashCode();
      return result;
  }

  
} 

//Hello
