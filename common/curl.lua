require "curl"
ngx.header.content_type = "text/html"
function get_html(url, c)
    local buf = { }
    if c == nil then 
        c = curl.easy_init() 
    end
    c:setopt(curl.OPT_URL, url)
    c:setopt(curl.OPT_TIMEOUT, 10)
    c:setopt(curl.OPT_WRITEFUNCTION, function(buffer, tab)
	buf = buffer
	return #buffer
    end)
    --c:perform()
    local ok = c:perform()
    return ok, buf
end

errmsg = {}
errmsg[0] = "All fine. Proceed as usual."
errmsg[1] = "The URL you passed to libcurl used a protocol that this libcurl does not support. The support might be a compile-time option that you didn't use, it can be a misspelled protocol string or just a protocol libcurl has no code for."
errmsg[2] = "Very early initialization code failed. This is likely to be an internal error or problem, or a resource problem where something fundamental couldn't get done at init time."
errmsg[3] = "The URL was not properly formatted."
errmsg[4] = "A requested feature, protocol or option was not found built-in in this libcurl due to a build-time decision. This means that a feature or option was not enabled or explicitly disabled when libcurl was built and in order to get it to function you have to get a rebuilt libcurl."
errmsg[5] = "Couldn't resolve proxy. The given proxy host could not be resolved."
errmsg[6] = "Couldn't resolve host. The given remote host was not resolved."
errmsg[7] = "Failed to connect() to host or proxy."
errmsg[8] = "After connecting to a FTP server, libcurl expects to get a certain reply back. This error code implies that it got a strange or bad reply. The given remote server is probably not an OK FTP server."
errmsg[9] = "We were denied access to the resource given in the URL. For FTP, this occurs while trying to change to the remote directory."
errmsg[10] = "While waiting for the server to connect back when an active FTP session is used, an error code was sent over the control connection or similar."
errmsg[11] = "After having sent the FTP password to the server, libcurl expects a proper reply. This error code indicates that an unexpected code was returned."
errmsg[12] = "During an active FTP session while waiting for the server to connect, the CURLOPT_ACCEPTTIMOUT_MS (or the internal default) timeout expired."
errmsg[13] = "libcurl failed to get a sensible result back from the server as a response to either a PASV or a EPSV command. The server is flawed."
errmsg[14] = "FTP servers return a 227-line as a response to a PASV command. If libcurl fails to parse that line, this return code is passed back."
errmsg[15] = "An internal failure to lookup the host used for the new connection."
errmsg[17] = "Received an error when trying to set the transfer mode to binary or ASCII."
errmsg[18] = "A file transfer was shorter or larger than expected. This happens when the server first reports an expected transfer size, and then delivers data that doesn't match the previously given size."
errmsg[19] = "This was either a weird reply to a 'RETR' command or a zero byte transfer complete."
errmsg[21] = "When sending custom \"QUOTE\" commands to the remote server, one of the commands returned an error code that was 400 or higher (for FTP) or otherwise indicated unsuccessful completion of the command."
errmsg[22] = "This is returned if CURLOPT_FAILONERROR is set TRUE and the HTTP server returns an error code that is >= 400."
errmsg[23] = "An error occurred when writing received data to a local file, or an error was returned to libcurl from a write callback."
errmsg[25] = "Failed starting the upload. For FTP, the server typically denied the STOR command. The error buffer usually contains the server's explanation for this."
errmsg[26] = "There was a problem reading a local file or an error returned by the read callback."
errmsg[27] = "A memory allocation request failed. This is serious badness and things are severely screwed up if this ever occurs."
errmsg[28] = "Operation timeout. The specified time-out period was reached according to the conditions."
errmsg[30] = "The FTP PORT command returned error. This mostly happens when you haven't specified a good enough address for libcurl to use. See CURLOPT_FTPPORT."
errmsg[31] = "The FTP REST command returned error. This should never happen if the server is sane."
errmsg[33] = "The server does not support or accept range requests."
errmsg[34] = "This is an odd error that mainly occurs due to internal confusion."
errmsg[35] = "A problem occurred somewhere in the SSL/TLS handshake. You really want the error buffer and read the message there as it pinpoints the problem slightly more. Could be certificates (file formats, paths, permissions), passwords, and others."
errmsg[36] = "The download could not be resumed because the specified offset was out of the file boundary."
errmsg[37] = "A file given with FILE:// couldn't be opened. Most likely because the file path doesn't identify an existing file. Did you check file permissions?"
errmsg[38] = "LDAP cannot bind. LDAP bind operation failed."
errmsg[39] = "LDAP search failed."
errmsg[41] = "Function not found. A required zlib function was not found."
errmsg[42] = "Aborted by callback. A callback returned \"abort\" to libcurl."
errmsg[43] = "Internal error. A function was called with a bad parameter."
errmsg[45] = "Interface error. A specified outgoing interface could not be used. Set which interface to use for outgoing connections' source IP address with CURLOPT_INTERFACE."
errmsg[47] = "Too many redirects. When following redirects, libcurl hit the maximum amount. Set your limit with CURLOPT_MAXREDIRS."
errmsg[48] = "An option passed to libcurl is not recognized/known. Refer to the appropriate documentation. This is most likely a problem in the program that uses libcurl. The error buffer might contain more specific information about which exact option it concerns."
errmsg[49] = "A telnet option string was Illegally formatted."
errmsg[51] = "The remote server's SSL certificate or SSH md5 fingerprint was deemed not OK."
errmsg[52] = "Nothing was returned from the server, and under the circumstances, getting nothing is considered an error."
errmsg[53] = "The specified crypto engine wasn't found."
errmsg[54] = "Failed setting the selected SSL crypto engine as default!"
errmsg[55] = "Failed sending network data."
errmsg[56] = "Failure with receiving network data."
errmsg[58] = "problem with the local client certificate."
errmsg[59] = "Couldn't use specified cipher."
errmsg[60] = "Peer certificate cannot be authenticated with known CA certificates."
errmsg[61] = "Unrecognized transfer encoding."
errmsg[62] = "Invalid LDAP URL."
errmsg[63] = "Maximum file size exceeded."
errmsg[64] = "Requested FTP SSL level failed."
errmsg[65] = "When doing a send operation curl had to rewind the data to retransmit, but the rewinding operation failed."
errmsg[66] = "Initiating the SSL Engine failed."
errmsg[67] = "The remote server denied curl to login (Added in 7.13.1"
errmsg[68] = "File not found on TFTP server."
errmsg[69] = "Permission problem on TFTP server."
errmsg[70] = "Out of disk space: on the server."
errmsg[71] = "Illegal TFTP operation."
errmsg[72] = "Unknown TFTP transfer ID."
errmsg[73] = "File already exists and will not be overwritten."
errmsg[74] = "This error should never be returned by a properly functioning TFTP server."
errmsg[75] = "Character conversion failed."
errmsg[76] = "Caller must register conversion callbacks."
errmsg[77] = "Problem with reading the SSL CA cert (path? access rights?"
errmsg[78] = "The resource referenced in the URL does not exist."
errmsg[79] = "An unspecified error occurred during the SSH session."
errmsg[80] = "Failed to shut down the SSL connection."
errmsg[81] = "Socket is not ready for send/recv wait till it's ready and try again. This return code is only returned from curl_easy_recv(3) and curl_easy_send(3) (Added in 7.18.2"
errmsg[82] = "Failed to load CRL file (Added in 7.19.0"
errmsg[83] = "Issuer check failed (Added in 7.19.0"
errmsg[84] = "The FTP server does not understand the PRET command at all or does not support the given argument. Be careful when using CURLOPT_CUSTOMREQUEST, a custom LIST command will be sent with PRET CMD before PASV as well. (Added in 7.20.0"
errmsg[85] = "Mismatch of RTSP CSeq numbers."
errmsg[86] = "Mismatch of RTSP Session Identifiers."
errmsg[87] = "Unable to parse FTP file list (during FTP wildcard downloading)."
errmsg[88] = "Chunk callback reported error."

ok, html = get_html("http://www.baidu.com/")
if ok > 0 then
	ngx.print (errmsg[ok], html)
else
	ngx.print ("success", html)
end
