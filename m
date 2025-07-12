Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D716A320F
	for <linux-openrisc@vger.kernel.org>; Sat, 12 Jul 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752304309; cv=none; b=iFqgrjVMwwgTpG060bGAODSvRyCUGchKE+6aGUE+V/aEKkkTHvmI7GUpMNXjLc+ANmdak07bNd1egolqBXvLBtSrW9cQayJHek98FzDFtmaquhhCADl77bpHydtXx2cP9/iDurF2cbu8j91H6B1g8JUJJRIK/l9kdUxH4lxgoRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752304309; c=relaxed/simple;
	bh=5ozMrOZNwyeraU5KdM+lU7iuEZTD4wM/v50qyy3IkCM=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=lInVn8uRqEi6w9/QDlrnFyYHpqm9ZWD3luRmTFGFJIMUGD/AMiSlEkbNRJnf+IT0Xo6iz77XIvbC9xN9qbOAYI+/tP9IYcGg5Bjxqu3+fXO0cFwtcKyWSyQvQ8rSaZTVuBfI1XzB03c8ObSqzLXx91DuIzFqenpnN+D9H0GOySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Oy2uyJwT; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Oy2uyJwT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752304303;
	bh=5ozMrOZNwyeraU5KdM+lU7iuEZTD4wM/v50qyy3IkCM=;
	h=From:To:Subject:Date;
	b=Oy2uyJwT5+c7aNGXX7SGe8bR8PT7igcN62KMm8uLkMrJqzGy1x7uYmyqozVgG0sor
	 hIEt7RJiswXGVdRlIK5ByelpDkaJk5FyvlD0+TuD1gZlu1GPXneVpiCjN3dGFE7UqU
	 dN3B+/IFvEFVCjfXbwXVr1q1vAAsLEtVHYM9qGB8=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-XMAILINFO: MsXRu/p5kTbfpvkHIvfp3oTjHow4ZtP1k4BwopB9ZR2uGRwwh1hBWmgXM3Zo6O
	 YbGzaxfcAih2VeEgD5wo8/LtVsc+nqO+SWgFWwvaX7bNsPyRBPm9pHlg1kBaC9FP98vGdEMKBCbkk
	 IO+NvRghbbuj7i4ttAmVdWWA+z4RaiYFkilkSldiW8QTfbpLcbD2ibU70CfiNblb7L3Jfhlbgd7uz
	 1fNRPuzQKXDuIPLKjk2A3RAkFxRt7D2C0rXNSair6DIuU4j/5ZeAv2VtBN62EMLsONyB6MCA6VfPu
	 xvx+mw3RH8safzrWDOKU0Cb/QxW+ErG2Fu41h3ONbr2NhzPhlzMyC7WchLvY0QFBYStFMR43n7KJa
	 ag9eXst+9/4UVNtXQyjuSxjMQN/bYvJY7j6Il4B8aIiqaFZrUfjMv2abVuxGPyC4U2zfLujLC+Ihf
	 ujVAFAd1VuDpiUlgnblwjYAyccJYH8LnSK25Eb+f0I17exfJ1wFGz6U3RevIdluOM++Ep9M0Njnj1
	 TXeF6Hdcqe6yAVhCIagroP4ssY/BGrEEWrrDoXqaGkVdKJ25U75TOjVm6tZdC0kG1a8Ph1XNc06s5
	 BNUBMFyUIfIELtJi2JO68hJ95BfZ72Hw9mGuYQ9fJaJmSoj/s0b2STyjDZfDppkW1XSt279UVHhqB
	 zWvCGwwsI+IP1RxFeVZjuiBAm6n9bYkmFCldTLC9aZVzKywXXayQ9+MA8Ww99fDaKDHMsl8fCcikm
	 qmxe/HBoedKYtMBrJD2/L6TFZfmfOkihwvbIMklmkMyBQ8RBKTnh4204ANcPDsOQjow0cQbw8WtQA
	 g1CTptvdRUWj9OabCnCEAvN8QeiX0/6AG1K85XHPi6F1BDaUD6lnmNndzhV5ebw6x0AXnzRVw1OHM
	 Kpzp0sUbpbKlhACqRbDQpwayYRVnqS9BOjCkJYHgxzazVxvWoV/PXUYoh4KC/rDsz7JQnAm8JfmkW
	 nogTtuQPyJFrdReEY6Ztw52w4EyxF1hjg/f4hiXaEaiS0a8NHHAyPoXdvaKEuIlaFyJVduBejROjc
	 VZRyFzPtnxKFTzkJ/+e8jZw0MF5+ImmMTR3LcaF3QS+u1G9U=
From: "=?utf-8?B?R2FyeSBMYXU=?=" <zgliu@foxmail.com>
To: "=?utf-8?B?bGludXgtb3BlbnJpc2M=?=" <linux-openrisc@vger.kernel.org>
Subject: [Question]or1k-elf/or1k-linux Windows/Cygwin toolchain availability?
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 12 Jul 2025 15:11:43 +0800
X-Priority: 3
Message-ID: <tencent_D7671DAE3F2DCA4F5AAD8A421C72F3568E08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb29-0t1752304303tp5sk7rnd

SGkgb3BlbnJpc2MgZm9sa3MsIMKgCgpJ4oCZbSBleHBsb3JpbmcgT3BlblJJU0MgZGV2ZWxv
cG1lbnQgYW5kIHdvdWxkIGxpa2UgdG8gYnVpbGQgdGhlIGxpbnV4IGtlcm5lbC9idXN5Ym94
IHJvb3RmcyBvbiBXaW5kb3dzL0N5Z3dpbi4gCkkgd2FudGVkIHRvIGNoZWNrOiDCoAoxLiBB
cmUgcHJlYnVpbHQgb3Ixay1lbGYgYW5kIG9yMWstbGludXggdG9vbGNoYWlucyBhdmFpbGFi
bGUgZm9yIFdpbmRvd3MvQ3lnd2luPyDCoAoyLiBJZiBub3QsIGlzIGNyb3NzLWNvbXBpbGlu
ZyBmcm9tIEN5Z3dpbiBmZWFzaWJsZSwgb3IgaXMgYSBuYXRpdmUgTGludXggaG9zdCBzdHJv
bmdseSByZWNvbW1lbmRlZD8gwqAKCkkgY2hlY2tlZCB0aGUgT3BlblJJU0MgZG9jcyBhbmQg
dG9vbGNoYWluIHJlcG9zIGJ1dCBjb3VsZG7igJl0IGZpbmQgV2luZG93cy1zcGVjaWZpYyDC
oApndWlkYW5jZS4gQW55IHBvaW50ZXJzIHdvdWxkIGJlIGhlbHBmdWwhIMKgCgpUaGFua3Ms
IMKgCkdhcnkgTGF1Cgo=

