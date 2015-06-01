function Import-509Certificate {
 
 param([String]$certPath,[String]$certRootStore,[String]$certStore)
 
$pfx = new-object System.Security.Cryptography.X509Certificates.X509Certificate2
$pfx.import($certPath)
 
$store = new-object System.Security.Cryptography.X509Certificates.X509Store($certStore,$certRootStore)
$store.open('MaxAllowed')
$store.add($pfx)
$store.close()
}
Import-509Certificate "path\to\cert.cer" "LocalMachine" "root"
EnableAdmin