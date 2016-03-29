<% 
	
	set crypt = Server.CreateObject("paytm.CheckSum") 
  	
	json= "{'MID':'worldp64425807474247','ORDER_ID':'ORD1234','CUST_ID':'sanjay','TXN_AMOUNT':'10','CHANNEL_ID':'WEB','INDUSTRY_TYPE_ID':'Retail','WEBSITE':'worldpressplg'}"
  checksum=crypt.generateCheckSum("kbzk1DSbJiV_o3p5",json)	
	
  res=crypt.verifyCheckSum("1LKl7aJBT7BBRXmx", "{'MID':'fIpbvO34900761501999','ORDERID':'32109259','TXNAMOUNT':'149.00','CURRENCY':'INR','TXNID':'816847199','BANKTXNID':'05C56CF631007F0B','STATUS':'TXN_SUCCESS','RESPCODE':'01','RESPMSG':'Txn Successful.','TXNDATE':'2015-01-03 14:53:32.0','GATEWAYNAME':'WALLET','BANKNAME':'','PAYMENTMODE':'PPI'}", "+pVP4HLDnX1qgc+1MopoVE9LyVnsXeIJxvANdU16p9yr3izT0EBVGhvTxUXnKiiTMwkACzZ4S7P471UkL70sBI85O+p2rhAZ8WaMJCdFEyQ=")
	response.write(res)
	if res =true then
		response.write("Valid")
	else
		response.write("Invalid")
	end if

%> 