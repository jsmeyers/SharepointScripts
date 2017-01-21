 $SPsite = Get-SPSite "http://sharepointsite"  
   
 foreach($SPWeb in $SPsite.AllWebs)

 {  
$pl = $SPWeb.Lists |? {$_.Title -eq "Pages"}
foreach($item in $pl.Items){
$url = [String]::Format("{0}/{1}",$spweb.Url, $item.File.Url)
$file = $SPWeb.GetFile($url)
$file
$file.undocheckout()
$file.CheckOut()
$wpm = $SPWeb.GetLimitedWebPartManager($url,  [System.Web.UI.WebControls.WebParts.PersonalizationScope]::Shared)   
$wp = $wpm.WebParts


foreach($badwp in $wp)            
{            
$badwp.title       
$badwp.width="";       
$wpm.savechanges($badwp)
}         
            
$file.CheckIn(“Update via PowerShell”,[Microsoft.SharePoint.SPCheckinType]::MajorCheckIn)         
$file.publish("Remove Width") 
}
}


