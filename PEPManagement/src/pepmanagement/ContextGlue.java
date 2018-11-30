package pepmanagement;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.UploadContext;

public class ContextGlue implements UploadContext {
	HttpServletRequest request;
	
	public ContextGlue(HttpServletRequest trequest) {
		request = trequest;
	}

	@Override
	public String getCharacterEncoding() {
		return request.getCharacterEncoding();
	}

	@Override
	public String getContentType() {
		return request.getContentType();
	}

	@Override
	public InputStream getInputStream() throws IOException {
		return request.getInputStream();
	}

	@Override
	public long contentLength() {
		return request.getContentLength();
	}
	

}
