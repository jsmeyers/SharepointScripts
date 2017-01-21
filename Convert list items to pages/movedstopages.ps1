

$SPsite = Get-SPSite "http://sharepointsite"  


   
 foreach($SPWeb in ($SPSite.AllWebs |? {$_.Title -ne "Blog"}))

 {
$SPWeb  
$ds = $SPWeb.Lists |? {$_.Title -eq "Department Services"}


foreach($item in $ds.Items){
$dstitle = $item["Title"]
#$dstitle
$dsbody = $item["Body"]
#$dsbody
$dscss = $item["City Service Status"]
#$dscss
$dscsc = $item["City Services Category"]
#$dscsc
$dsexpires = $item["Expires"]
#$dsexpires
# Get the Page URL
$dstitle1 = $dstitle.replace('.','')
$plpagename = $dstitle1 + ".aspx"
#$plpagename
$plpagename = $plpagename.replace(" ","-")
#$plpagename
$plpagename = $plpagename.replace(",","")
#$plpagename
$plpagename = $plpagename.replace("'","")
#$plpagename
$plpagename = $plpagename.replace('"','')
#$plpagename
$plpagename = $plpagename.replace('?','')
#$plpagename
$plpagename = $plpagename.replace('/','')
#$plpagename
$plpagename = $plpagename.replace(')','')
#$plpagename
$plpagename = $plpagename.replace('(','')
#$plpagename
$plpagename = $plpagename.replace('&','')
#$plpagename
$plpagename = $plpagename.replace('#','')
#$plpagename
$plpagename = $plpagename.replace('!','')
$plpagename

$dscss1 = New-Object Microsoft.SharePoint.SPFieldMultiChoiceValue
$dscss1.Add($dscss)
$web = $SPWeb
$pWeb = [Microsoft.SharePoint.Publishing.PublishingWeb]::GetPublishingWeb($web)
$pageLayout = $pWeb.GetAvailablePageLayouts() | Where { $_.Name -eq "COLServicePageLayout.aspx" }
$page = $pWeb.GetPublishingPages().Add($plpagename, $pageLayout)
#$page.checkout()
$page.Title = $dstitle
$page.ListItem["Page Content"] = $dsbody
$page.ListItem["City Service Status"] = $dscss
$page.ListItem["City Services Category"] = $dscsc
$page.ListItem["Expiration Date"] = $dsexpires
$page.update()
$page.ListItem.Update()
$page.ListItem.systemUpdate()
$page.CheckIn("")
$page.ListItem.file.Publish("Move City Services")

}
}


