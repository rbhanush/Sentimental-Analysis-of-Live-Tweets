<%@page import="database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>
<jsp:include page="header.jsp"></jsp:include>
<!--flex slider-->
<script defer src="js/jquery.flexslider.js"></script>
<link rel="stylesheet" href="css/flexslider.css" type="text/css" media="screen" />
<script>
	// Can also be used with $(document).ready()
	$(window).load(function() {
	  $('.flexslider').flexslider({
		animation: "slide",
		controlNav: "thumbnails"
	  });
	});
</script>
<!--flex slider-->
<script src="js/imagezoom.js"></script>
<!-- //js --> 
<!-- //header --> 
	<!-- breadcrumbs --> 
	<div class="container"> 
		<ol class="breadcrumb breadcrumb1">
			<li><a href="index.html">Home</a></li>
			<li class="active">Single Page</li>
		</ol> 
		<div class="clearfix"> </div>
	</div>
	<!-- //breadcrumbs -->
	<!-- products -->
	<div class="products">	 
		<div class="container">  
			<div class="single-page">
<%
				DatabaseConnection db = new DatabaseConnection();
				db.dbconnection();
				ResultSet rs = null;
				int i=0;
				String proid=request.getParameter("pid");
				
					String sql="Select * from products Where id='"+proid+"'";
					rs=db.getResultSet(sql);
												
					if(rs.next())
					{
						String pid = rs.getString("id");
						String pname = rs.getString("pname");
						String pprice = rs.getString("pprice");
						String pstock = rs.getString("pstock");
						String pcate = rs.getString("pcate");
						String pscate = rs.getString("pscate");
						int stock = Integer.parseInt(pstock);
						
						String image1 = rs.getString("image1");
						String image2 = rs.getString("image2");
						String image3 = rs.getString("image3");
						String description = rs.getString("description");
						
						
%>
				<div class="single-page-row" id="detail-21">
					<div class="col-md-6 single-top-left">	
						<div class="flexslider">
							<ul class="slides">
								<li data-thumb="../admin/product/<%=image1%>">
									<div class="thumb-image detail_images"> <img src="../admin/product/<%=image1%>" data-imagezoom="true" class="img-responsive" alt=""> </div>
								</li>
								<!-- 
								<li data-thumb="../admin/product/<%=image2%>">
									 <div class="thumb-image"> <img src="../admin/product/<%=image2%>" data-imagezoom="true" class="img-responsive" alt=""> </div>
								</li>
								<li data-thumb="../admin/product/<%=image3%>">
								   <div class="thumb-image"> <img src="../admin/product/<%=image3%>" data-imagezoom="true" class="img-responsive" alt=""> </div>
								</li> 
								 -->
							</ul>
						</div>
					</div>
					<div class="col-md-6 single-top-right">
						<h3 class="item_name"><%=pname%></h3>
						<p>Processing Time: Item will be shipped out within 2-3 working days. </p>
						<div class="single-rating">
							<ul>
								<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								<li><i class="fa fa-star-o" aria-hidden="true"></i></li>
								<li class="rating">20 reviews</li>
<!-- 								<li><a href="#">Add your review</a></li> -->
							</ul> 
						</div>
						<div class="single-price">
							<ul>
								<li><%=pprice%>Rs.</li>  
								<!--<li><del>$600</del></li>-->  
								<%if(stock > 0){%>
								<li><span class="w3off">In Stock</span></li> 
								<%}else{%>
								<li><span class="w3off" style="color:red">Out Of Stock</span></li>
								<%}%>
								<!-- <li>Ends on: June,5th</li>
								<li><a href="#"><i class="fa fa-gift" aria-hidden="true"></i> Coupon</a></li>-->
							</ul>	
						</div>
						<p class="single-price-text"><%=description%></p><br><br>
						<form action="#" method="post">
							<button type="button" onclick="addCart(<%=pid%>)" class="w3ls-cart" ><i class="fa fa-cart-plus" aria-hidden="true"></i> Add to cart</button>
						</form>
<!-- 						<h4 style="float:right">Rate For Products</h4> -->
						<div style="float:right">
							<link href="css/starcss.css" rel="stylesheet" type="text/css" media="all" /> 
							<h1>Rate For Products</h1>
							<fieldset class="rating1">
							    <input type="radio" id="star5" name="rating1" value="5" onclick="rate(this.value,'<%=pid%>')"/><label class = "full" for="star5" title="Awesome - 5 stars"></label>
							    <input type="radio" id="star4half" name="rating1" value="4.5" onclick="rate(this.value,'<%=pid%>')")"/><label class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
							    <input type="radio" id="star4" name="rating1" value="4" onclick="rate(this.value,'<%=pid%>')"/><label class = "full" for="star4" title="Pretty good - 4 stars"></label>
							    <input type="radio" id="star3half" name="rating1" value="3.5" onclick="rate(this.value,'<%=pid%>')"/><label class="half" for="star3half" title="Meh - 3.5 stars"></label>
							    <input type="radio" id="star3" name="rating1" value="3" onclick="rate(this.value,'<%=pid%>')"/><label class = "full" for="star3" title="Meh - 3 stars"></label>
							    <input type="radio" id="star2half" name="rating1" value="2.5" onclick="rate(this.value,'<%=pid%>')"/><label class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
							    <input type="radio" id="star2" name="rating1" value="2" onclick="rate(this.value,'<%=pid%>')"/><label class = "full" for="star2" title="Kinda bad - 2 stars"></label>
							    <input type="radio" id="star1half" name="rating1" value="1.5" onclick="rate(this.value,'<%=pid%>')"/><label class="half" for="star1half" title="Meh - 1.5 stars"></label>
							    <input type="radio" id="star1" name="rating1" value="1" onclick="rate(this.value,'<%=pid%>')"/><label class = "full" for="star1" title="Sucks big time - 1 star"></label>
							    <input type="radio" id="starhalf" name="rating1" value="0.5" onclick="rate(this.value,'<%=pid%>')"/><label class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
							</fieldset>
						</div>
					</div>
				   <div class="clearfix"> </div>  
				</div>
<%
					}
%>
			</div> 
						<!-- recommendations -->
	<!--			<div class="recommend">
				<h3 class="w3ls-title">Our Recommendations Using Reviews </h3> 
				<script>
					$(document).ready(function() { 
						$("#owl-demo5").owlCarousel({
					 
						  autoPlay: 3000, //Set AutoPlay to 3 seconds
					 
						  items :4,
						  itemsDesktop : [640,5],
						  itemsDesktopSmall : [414,4],
						  navigation : true
					 
						});
						
					}); 
				</script>
				<div id="owl-demo5" class="owl-carousel">
		<%
			String sql1="Select * from commentsrate ORDER BY positiveper ASC";
			ResultSet rs1=db.getResultSet(sql1);
										
			while(rs1.next())
			{
				String pid1 = rs1.getString("pid");
				String positiveper = rs1.getString("positiveper");
				
				String sql2="Select * from products Where id='"+pid1+"'";
				ResultSet rs2=db.getResultSet(sql2);		
				if(rs2.next())
				{
					String pname2 = rs2.getString("pname");
					String str2 = pname2.substring(0, 10)+"...";
					String image12 = rs2.getString("image1");
					String pprice2 = rs2.getString("pprice");
		 %>
				
					<div class="item">
						<div class="glry-w3agile-grids agileits">
							<div class="new-tag"><h6>Sale</h6></div>
							<a href="products1.jsp"><img src="../admin/product/<%=image12%>" alt="img" style="height:300px;"></a>
							<div class="view-caption agileits-w3layouts">           
								<h4><a href="products1.jsp"><%=str2%></a></h4>
								<p>Positive Reviews Percentage:-<%=positiveper%></p>
								<h5><%=pprice2%></h5>
								<form action="#" method="post"> 
									<button type="button" onclick="addCart(<%=pid1%>)" class="w3ls-cart" ><i class="fa fa-cart-plus" aria-hidden="true"></i> Add to cart</button>
								</form>
							</div>        
						</div> 
					</div>
		<%
				}
			}
		%>
				</div>    
			</div> -->
			<!-- //Reviews recommendations -->
					
		<div class="clearfix"> </div>
			<!-- recommendations -->
		
		
		<div class="recommend">
					<h3 class="w3ls-title">Recommendation Based on Ratings </h3> 
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
				String sql3="Select * from twitsrate ORDER BY postiverate ASC";
				ResultSet rs3=db.getResultSet(sql3);
											
				while(rs3.next())
				{
					String pid3 = rs3.getString("pid");
					String positiveper3 = rs3.getString("postiverate");
					
					String sql4="Select * from products Where twits='"+pid3+"'";
					ResultSet rs4=db.getResultSet(sql4);		
					if(rs4.next())
					{
						String pname4 = rs4.getString("pname");
						String str4 = pname4.substring(0, 10)+"...";
						String image14 = rs4.getString("image1");
						String pprice4 = rs4.getString("pprice");
			 %>
						<div class="item">
							<div class="glry-w3agile-grids agileits">
								<div class="new-tag"><h6>Sale</h6></div>
								<a href="products1.jsp"><img src="../admin/product/<%=image14%>" alt="img" style="height:300px;"></a>
								<div class="view-caption agileits-w3layouts">           
									<h4><a href="products1.jsp"><%=str4%></a></h4>
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
			<!-- collapse-tabs -->
			<div class="collpse tabs">
				<h3 class="w3ls-title">About this item</h3> 
				<div class="panel-group collpse" id="accordion" role="tablist" aria-multiselectable="true">
			<!-- 		<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingOne">
							<h4 class="panel-title">
								<a class="pa_italic" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
									<i class="fa fa-file-text-o fa-icon" aria-hidden="true"></i> Description <span class="fa fa-angle-down fa-arrow" aria-hidden="true"></span> <i class="fa fa-angle-up fa-arrow" aria-hidden="true"></i>
								</a>
							</h4>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
							<div class="panel-body">
							
							</div>
						</div>
					</div>  -->
					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingTwo">
							<h4 class="panel-title">
								<a class="collapsed pa_italic" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
									<i class="fa fa-info-circle fa-icon" aria-hidden="true"></i> additional information <span class="fa fa-angle-down fa-arrow" aria-hidden="true"></span> <i class="fa fa-angle-up fa-arrow" aria-hidden="true"></i>
								</a> 
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
							<div class="panel-body">
								1 year manufacturer warranty for device and 6 months manufacturer warranty for in-box accessories including batteries from the date of purchase.
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingThree">
							<h4 class="panel-title">
								<a class="collapsed pa_italic" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
									<i class="fa fa-check-square-o fa-icon" aria-hidden="true"></i> reviews (5) <span class="fa fa-angle-down fa-arrow" aria-hidden="true"></span> <i class="fa fa-angle-up fa-arrow" aria-hidden="true"></i>
								</a>
							</h4>
						</div>
						<div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
							<div class="panel-body">
				
						
								
							</div>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading" role="tab" id="headingFour">
							<h4 class="panel-title">
								<a class="collapsed pa_italic" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
									<i class="fa fa-question-circle fa-icon" aria-hidden="true"></i> help <span class="fa fa-angle-down fa-arrow" aria-hidden="true"></span> <i class="fa fa-angle-up fa-arrow" aria-hidden="true"></i>
								</a>
							</h4>
						</div>
						<div id="collapseFour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingFour">
							<div class="panel-body">
								<i>Contact Customer Care</i>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- //collapse --> 
		</div>
	</div>
	<!--//products-->  
			<!-- menu js aim -->
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>