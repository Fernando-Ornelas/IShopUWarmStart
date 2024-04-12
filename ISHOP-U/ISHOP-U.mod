/*********************************************
 * OPL 22.1.0.0 Model
 * Author: Fernando Ornelas
 * Creation Date: 18 ago 2022 at 18:31:07
 *********************************************/

string nomArchivo = "UniformS1.csv"; //Nombre de archivo
int NProductos; //Numero de productos fijados para una instancia
int NTiendas; //Numero de tiendas fijadas para una instancia
range Productos = 0..NProductos-1; //Rango de productos
range Tiendas = 0..NTiendas-1; //Rango de tiendas
int L[Productos];  //Arreglo de unidades a comprar L de cada producto
float D[Tiendas]; //Arreglo de gastos de envío D para cada tienda
float C[Tiendas][Productos]; //Matriz C de precio unitario de producto en cada tienda
int A[Tiendas][Productos]; //Matriz A de unidades producto disponible en cada tienda

//Código para cargar la instancia
execute
{
  	
  var archivo = new IloOplInputFile(nomArchivo);
  var renglon;
  var tokens;
  renglon = archivo.readline(); //#NO_PRODUCTS, NO_STORES
  renglon = archivo.readline();
  tokens = renglon.split(",");
  NProductos = Opl.intValue(tokens[0]);
  NTiendas = Opl.intValue(tokens[1]);
  renglon = archivo.readline(); //#PRODUCT_NO, QUANTITY_TO_BUY
  for(var producto in Productos) {
  	  renglon = archivo.readline();
  	  tokens = renglon.split(",");
  	  L[producto] = Opl.intValue(tokens[1]);	      
  }
  renglon = archivo.readline(); //#STORE_NO, DELIVERY_PRICE
  for(var tienda in Tiendas) {
  	renglon = archivo.readline();
  	tokens = renglon.split(",");
  	D[tienda] = Opl.floatValue(tokens[1]);	      
  }
  renglon = archivo.readline(); //#MATRIX OF PRICES (ROWS STORES - COLUMNS PRODUCTS)
  for(var tienda in Tiendas) {
  	renglon = archivo.readline();
  	tokens = renglon.split(",");
    for(var producto in Productos) {
    	C[tienda][producto] = Opl.floatValue(tokens[producto]); 
    }  
  }
  renglon = archivo.readline(); //#MATRIX OF AVAILABILITY (ROWS STORES - COLUMNS PRODUCTS)
  for(var tienda in Tiendas) {
  	renglon = archivo.readline();
  	tokens = renglon.split(",");
    for(var producto in Productos) {
    	A[tienda][producto] = Opl.intValue(tokens[producto]); 
    }  
  }          
}

dvar int+ S[Tiendas][Productos]; //Matriz de variables de decisión x
dvar boolean y[Tiendas];

minimize sum(i in Tiendas)(sum(j in Productos)S[i][j] * C[i][j] + y[i] * D[i]);

subject to
{ 
  //Correcta 
	forall(i in Tiendas)
	{
	  (sum(j in Productos)S[i][j] == 0) => (y[i] == 0);  //Otherwise
	  (sum(j in Productos)S[i][j] != 0) => (y[i] == 1);
 	}	  
            
  //Correcta          
  forall(i in Tiendas,j in Productos)
    S[i][j] <= A[i][j];
  
  //Correcta  
  forall(j in Productos)
  	sum(i in Tiendas)S[i][j] == L[j];
}
