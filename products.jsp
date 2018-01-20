<%@page import="admin.sortmethod"%>
<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.LinkedHashSet"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<jsp:include page="header.jsp"></jsp:include>
<!--//////////////////////////////////////////////////////////-->
<!-- Fetch Reviews and Twist for analysis code call functions -->
<!--//////////////////////////////////////////////////////////-->
			<script type="text/javascript">
			window.onload = runthread();
			window.onload = runthread1();
			</script>
			<script type="text/javascript">
				setInterval(function() {
					reloadpage();
			      }, 300000); 
			</script>
<!--//////////////////////////////////////////////////////////-->
<!--//////////////////////////////////////////////////////////-->
<!--//////////////////////////////////////////////////////////-->
<%
DatabaseConnection db = new DatabaseConnection();
db.dbconnection();
	String cat=request.getParameter("cat");
	String subcat=request.getParameter("subcat");
	if(cat==null)
	{
		cat = (String) session.getAttribute("cat");
		subcat = (String) session.getAttribute("subcat");
		if(cat==null)
		{
			cat="1";
			subcat="1";
		}
	}
%>
	<!-- products -->
	<div class="products">	 
		<div class="container">		
			<div class="col-md-9 product-w3ls-right">
				<!-- breadcrumbs --> 
				<ol class="breadcrumb breadcrumb1">
					<li><a href="index.jsp">Home</a></li>
					<li class="active">Products</li>
				</ol> 
				<div class="clearfix"> </div>
				<!-- //breadcrumbs -->
				<div class="product-top">
					<h4>Fashion Store</h4>  
					<div class="clearfix"> </div>
				</div>
				<div class="products-row">
					
<%
				ResultSet rs = null;
				int i=0;							
					String sql="Select * from products Where pcate='"+cat+"' and pscate='"+subcat+"'";
					rs=db.getResultSet(sql);
												
					while(rs.next())
					{
						String pid = rs.getString("id");
						String pname = rs.getString("pname");
						String str = pname.substring(0, 10)+"...";
						String image1 = rs.getString("image1");
						String pprice = rs.getString("pprice");
						String pstock = rs.getString("pstock");
						String pcate = rs.getString("pcate");
						String pscate = rs.getString("pscate");
						int stock = Integer.parseInt(pstock);
%>
					<div class="col-md-3 product-grids"> 
						<div class="agile-products">
							<div class="new-tag"><h6>New</h6></div>
							<a href="single.jsp?pid=<%=pid%>"><img src="../admin/product/<%=image1%>" style="height:200px;" class="img-responsive" alt="img"></a>
							<div class="agile-product-text">              
								<h5><a href="single.jsp?pid=<%=pid%>"><%=str%></a></h5> 
								<h6><%=pprice%></h6> 
								<form action="#" method="post"> 
									<button type="button" onclick="addCart(<%=pid%>)" class="w3ls-cart pw3ls-cart"><i class="fa fa-cart-plus" aria-hidden="true"></i> Add to cart</button>
								</form> 
							</div>
						</div> 
					</div>
<%
					}
%>
					<div class="clearfix"> </div>
				</div>
			</div>
			<div class="col-md-3 rsidebar">
				<div class="rsidebar-top">
					<b style="font-size:20px;text-algin:center;">Highly Purchase & Popular Product</b>
				</div>
		<%
			List<String> list = new ArrayList<String>();
			String totalcount="Select * from transaction";
			ResultSet bestrs=db.getResultSet(totalcount);							
			while(bestrs.next())
			{
				String totalpid = bestrs.getString("totalpid");
				String[] splitdata=totalpid.split(",");
				for(int m=0;m<splitdata.length;m++)
				{
					list.add(splitdata[m]);
				}
			}
			int max=0;
			String getproduct="";
			Set<String> unique = new LinkedHashSet<String>(list);
			for (String key : unique) {
				int count=Collections.frequency(list, key);
// 				System.out.println(count);
// 			    System.out.println(key + ": " + Collections.frequency(list, key));
			    if(count >= max)
			    {
			    	max=count;	
			    	getproduct=key;
			    }
			}
			// System.out.println("higest"+getproduct);
			 String bestpro11="Select * from products Where id='"+getproduct+"'";
			 ResultSet bestrs11=db.getResultSet(bestpro11);
											
				while(bestrs11.next())
				{
					String pid = bestrs11.getString("id");
					String pname = bestrs11.getString("pname");
					String str = pname.substring(0, 10)+"...";
					String image1 = bestrs11.getString("image1");
					String pprice = bestrs11.getString("pprice");
		%>
				<div class="related-row">
					<h4>HIGHLY PURCHASE PRODUCT YOU MAY ALSO BUY IT</h4>
					<div class="galry-like">  
						<a href="single.jsp"><img src="../admin/product/<%=image1%>" class="img-responsive" alt="img"></a>             
						<h4><a href="products.jsp"><%=str%></a></h4> 
						<h5>Rs. <%=pprice%></h5>       
					</div>
				</div>
		<%
				}
		%>
<%
			
int high=0;
String getpid ="";
		String sqls="Select * from products";
		ResultSet res=db.getResultSet(sqls);			
		while(res.next())
		{
			String pid = res.getString("id");
			double sumrate1 = 0;
				String sql1="Select sum(rate) as sumrate from rate Where pid='"+pid+"'";
				ResultSet res1=db.getResultSet(sql1);							
				if(res1.next())
				{
					String sumrate = res1.getString("sumrate");
					if(sumrate!=null){
						sumrate1=Double.parseDouble(sumrate);
					}
				}
			if(sumrate1 > high)
			{
				getpid=pid;
			}
		}					
				String myque="Select * from products Where id='"+getpid+"'";
				ResultSet res11=db.getResultSet(myque);			
				if(res11.next())
				{
						String pid1 = res11.getString("id");
						String pname1 = res11.getString("pname");
						String str1 = pname1.substring(0, 10)+"...";
						String image11 = res11.getString("image1");
						String pprice1 = res11.getString("pprice");
		%>
				<div class="related-row">
					<h4>POPULAR PRODUCT YOU MAY ALSO BUY IT</h4>
					<div class="galry-like">  
						<a href="single.jsp"><img src="../admin/product/<%=image11%>" class="img-responsive" alt="img"></a>             
						<h4><a href="products.jsp"><%=str1%></a></h4> 
						<h5>Rs. <%=pprice1%></h5>       
					</div>
				</div>
		<%
				}
		%>
			</div>
			<div class="clearfix"> </div>
			<!-- recommendations -->
			
	<!-- User History part is in Comment -->
			
			
		<div id="loaddata">
			
			</div>
			<!-- //Reviews recommendations -->
					
		<div class="clearfix"> </div>
			<!-- recommendations -->
			<div class="recommend">
				<h3 class="w3ls-title">Our Recommendations Using Tweet Analysis </h3> 
				<script>
					$(document).ready(function() { 
						$("#owl-demo6").owlCarousel({
					 
						  autoPlay: 3000, //Set AutoPlay to 3 seconds
					 
						  items :4,
						  itemsDesktop : [640,5],
						  itemsDesktopSmall : [414,4],
						  navigation : true
					 
						});
						
					}); 
				</script>
				<div id="owl-demo6" class="owl-carousel">
		<%
			String sql3="Select * from twitsrate ORDER BY postiverate DESC";
			ResultSet rs3=db.getResultSet(sql3);
										
			while(rs3.next())
			{
				String pid3 = rs3.getString("pid");
				String positiveper3 = rs3.getString("postiverate");
				
				String sql4="Select * from products Where twits='"+pid3+"'";
				ResultSet rs4=db.getResultSet(sql4);		
				if(rs4.next())
				{
					int ppid = rs4.getInt("id");
					String pname4 = rs4.getString("pname");
					String str4 = pname4.substring(0, 10)+"...";
					String image14 = rs4.getString("image1");
					String pprice4 = rs4.getString("pprice");
		 %>
					<div class="item">
						<div class="glry-w3agile-grids agileits">
							<div class="new-tag"><h6>Sale</h6></div>
							<a href="single.jsp?pid=<%=ppid%>"><img src="../admin/product/<%=image14%>" alt="img" style="height:300px;"></a>
							<div class="view-caption agileits-w3layouts">           
								<h4><a href="single.jsp?pid=<%=ppid%>"><%=str4%></a></h4>
								<p>Positive Reviews Percentage:-<%=positiveper3%></p>
								<h5><%=pprice4%></h5>
								<form action="#" method="post">
									<button type="button"  onclick="addCart(<%=pid3%>)" class="w3ls-cart" ><i class="fa fa-cart-plus" aria-hidden="true"></i> Add to cart</button>
								</form>
							</div>        
						</div> 
					</div>
		<%
				}
			}
		%>
				</div>    
			</div>
			<!-- //twits recommendations -->
			</div>
		</div>
	</div>
	<!--//products-->  
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>
