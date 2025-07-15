Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2B7946A
	for <linux-openrisc@vger.kernel.org>; Tue, 15 Jul 2025 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552072; cv=none; b=aSgw33KZEifQ0JshiBLiZ/DKHs7pxbRYwE8dOjHxtCWnzqLkti5R/IdTNdhp1YbqrooZt3wms7CYW2zdY1KLWkNT9K2SQiFfaQ7tWsZ4+QYHtSld52r5/nip+2JCx7st6dC9pyK8cJl9zabgfcJG9rLPpYCMxXQddboW0uP9ktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552072; c=relaxed/simple;
	bh=CN+S9Mwb/OIqxNXmUECGP8U3PtSfgOUrMO5g+P+NTg8=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=Ju4x3RWl3h1Oxrb087vwZqVL52bkvnRoWuIEotsBQhq6dwnqWby/jD/meFhPAR0DecZR6vrSquVQE78XKYtf9khtxopMEpw022KuOBL2Vvh3dPECYZei99CzLsAhnBPyl+3CJffUeIskwTaE1ILjop8wi6rqi8vTqfiQPMaEO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=r2rnsNeX; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="r2rnsNeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752552060;
	bh=CN+S9Mwb/OIqxNXmUECGP8U3PtSfgOUrMO5g+P+NTg8=;
	h=From:To:Subject:Date;
	b=r2rnsNeXt2aX0+uO3VZ4xvMwH/3/6FwNPg5F13OoBtBBHHilI7PnNYjMxbVcEZqjA
	 D+E9eKOelrsnEOwfzzU82f33ya2ssMWjFYrX+GoNKmXahemrzX7DgyinvoQHck7YG+
	 jqNt0uFbBmLxDRbxSPoV1jYZCXXr7TgyAHctPMGA=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-XMAILINFO: Nvot78Ae2aERegUn2u7yhQQRRPHAMaAPw4ipnHn3BtICmyUkpNdrk+2qwe8abg
	 t0/InlRc9OLJEkMIPEaf7mNCVWimoecd9BTOlL74JSMTUEDWE0miYQYOXLdS5IIp4hVjCS+qeKMG6
	 xaMFwQVFqhvQIMluHUH9fCcPYigkuy2N0FpUQjXnEGDILMQKsi0hIgdyeg+3XNPh/dfNIEq9RIu6k
	 2GG1xjb1K8XwZeqjYSEeYbP42T3dhDxl9lluHCQWBzEGinKYK3NHzT7CqYXWlCsVqOmOcAQshYRdz
	 +f3wme5JiNZc/xx0mmgWkH3F/SQwiPKh6S2vxS7c4CIfhEkLWuIKC1+u/ECZY9pVNCX8DKF8H/s2e
	 7w0v1rbU5fgPoW2bc7JnP5/OJxUdNTCNB2aq5l+GYuJmNWlYUd7PXPA96qxKdtFtZqi2OXtBFAvO+
	 0+pAPMNODHx9GSuWqESXkBuQ55MguERmKcxLKdv4fhxV0/MXUL2Gi0EY4udlnZmfKn3WE/Z/gxHWg
	 vhhl3Tlcr+ZMNoe/5cSbIDi8o/B3V9OoUnnnRdloxDtYPpRAoAG4DSiylROfqldn7/IFsKr74uIPC
	 QgQ55ia7aoFumy52wk1UEsoOhRNRxtIE60QyrtMdrhzrTTk3cwQTz8V6Gfeby+KGosXgVCb9t0/oI
	 FnKPJktRvOYpI2q6SHd+pmAFj9PVlBXk56uCZOIVcizHD6MZm3qIe3ZTh6W7CWd/sVNdnr8hNcMn+
	 ciE/NtjMJajAKqaWGTqucmYAkF9r45+XKqBTp29NAe1ZwkGFYMUZWkutjVzAdCH7A00e8G1uUIRKv
	 1iOeaqLF15YRxkIZV2pW2KZD9XvP870QsN+vk2nBfZqzbYCVehVdLQ6iGgcg8/4Ur89v6n650u84W
	 tUX/TFM7Jw+gqRcSTOboZlP4hC4Fg5zf/118nbJsBgrNW0NfATuPDeZ4vmhgOLIiPrdC5M+fvV7w3
	 XG2Ml2bjWRsWH/1c8vJAJShJjpHg7hnspvz4cONhvUeYdELZ/K09KPp8afjB5J/bEHz/THaUs+8Il
	 yJzNZnybT1f9N6JvwQI3hYybrfaEF5Q08z63z
From: "=?utf-8?B?R2FyeSBMYXU=?=" <zgliu@foxmail.com>
To: "=?utf-8?B?bGludXgtb3BlbnJpc2M=?=" <linux-openrisc@vger.kernel.org>
Subject: [Questions] Inquiry about OpenRISC Multi-Core Support Status
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 15 Jul 2025 12:00:59 +0800
X-Priority: 3
Message-ID: <tencent_C8553A547F769459B4D614D938C0E6111C09@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb29-0t1752552059tux0pv1xd

RGVhciBPcGVuUklTQyBkZXZlbG9wZXJzIGFuZCBjb21tdW5pdHksCgpJ4oCZbSByZWFjaGlu
ZyBvdXQgdG8gaW5xdWlyZSBhYm91dCB0aGUgY3VycmVudCBzdGF0dXMgb2YgbXVsdGktY29y
ZSBzdXBwb3J0IGluIE9wZW5SSVNDLiBDb3VsZCB5b3UgcGxlYXNlIHNoYXJlIHNvbWUgZGV0
YWlscyBvbjoKMS4gV2hhdCBpcyB0aGUgbWF4aW11bSBudW1iZXIgb2YgT3BlblJJU0MgY29y
ZXMgY3VycmVudGx5IHN1cHBvcnRlZCBpbiB0aGUgTGludXgga2VybmVsPwoyLiBXaGljaCBz
cGVjaWZpYyBvcjFrIGNvcmUgaW1wbGVtZW50YXRpb24ocynCoGFyZSBiZWluZyB1c2VkIGZv
ciBtdWx0aS1jb3JlIHN1cHBvcnQgKGUuZy4sIG1vcjFreCwgbWFyb2NjaGlubyBldGMuKT8K
My4gSG93IG1hbnkgY29yZXMgaGF2ZSBiZWVuIHN1Y2Nlc3NmdWxseSB0ZXN0ZWQgYW5kIHZh
bGlkYXRlZCwgZWl0aGVyIGluIHJlYWwgaGFyZHdhcmXCoG9yIHNpbXVsYXRpb24gZW52aXJv
bm1lbnRzPwo0LiBXaGljaCBzaW11bGF0b3JzwqAoZS5nLiwgUUVNVSwgb3Ixa3NpbSwgZXRj
Likgc3VwcG9ydCBtdWx0aS1jb3JlIE9wZW5SSVNDIGVtdWxhdGlvbiwgYW5kIHdoYXQgYXJl
IHRoZWlyIGxpbWl0YXRpb25zPwo1LiBXaGF0IGFyZSB0aGUgcmVjb21tZW5kZWQgdmVyc2lv
bnMgb2YgTGludXgga2VybmVsIGFuZCBHQ0MgdG9vbGNoYWluIGZvciBtdWx0aS1jb3JlIE9w
ZW5SSVNDIGRldmVsb3BtZW50Pwo2LiBBcmUgdGhlcmUgYW55IGF2YWlsYWJsZSBkb2N1bWVu
dGF0aW9uwqBvciByZWZlcmVuY2UgbWF0ZXJpYWxzwqByZWdhcmRpbmcgT3BlblJJU0MgU01Q
L211bHRpLWNvcmUgaW1wbGVtZW50YXRpb24/CjcuIEFyZSB0aGVyZSBhbnkgcGFydGljdWxh
ciBjb25zaWRlcmF0aW9uc8Kgb3IgbGltaXRhdGlvbnPCoEkgc2hvdWxkIGJlIGF3YXJlIG9m
IHdoZW4gd29ya2luZyB3aXRoIG11bHRpLWNvcmUgT3BlblJJU0Mgc3lzdGVtcz8KCkFueSBp
bnNpZ2h0cywgZXhwZXJpZW5jZXMsIG9yIHBvaW50ZXJzIHRvIHJlbGV2YW50IHJlc291cmNl
cyB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLiBUaGFuayB5b3UgZm9yIHlvdXIgdGlt
ZSBhbmQgY29udHJpYnV0aW9ucyB0byB0aGUgT3BlblJJU0MgZWNvc3lzdGVtLgoKQmVzdCBy
ZWdhcmRzLApHYXJ5

