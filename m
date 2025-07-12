Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5341C3C14
	for <linux-openrisc@vger.kernel.org>; Sat, 12 Jul 2025 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752304161; cv=none; b=eicfyUumNcBaVo0hGyu63Gum1sDYeTnepfloEZY01ri/ZajIUxiVophMHbkm6t6LoyYqKg7Xo6aSxQ/3RdCBNRLa9L5f2onlgff+GzyFCtcpXWpwIeTlpc7MQfj5sujeWVoE4eXJq/jzgD5hqVMKhNHF1P5VetlSiQ6NO/zT+8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752304161; c=relaxed/simple;
	bh=1pbC4HBfwuTZW2bIIhQOSsmbscacuYzFnrGHzPj6hLc=;
	h=From:To:Subject:Mime-Version:Content-Type:Date:Message-ID; b=us8v0rzqAakwrFVKjD8nW1kgJ/QTz0vYX9Jh+0RnhLdQ/weL7x+Ijeky7LX7D85l47oX9hyKR5/KFlzMU4iVW5m7Nd6fFYgrwcLzHkf51EDnevkI1xqLtTwlAoemt6IuYGDdrb15KpG2C0V7tOQOOYBpdjslX4nmz2WyfCQ7bbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=niK5AjAL; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="niK5AjAL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752304155;
	bh=1pbC4HBfwuTZW2bIIhQOSsmbscacuYzFnrGHzPj6hLc=;
	h=From:To:Subject:Date;
	b=niK5AjALiWEQbeqQS49UlG2TfmJkRerKnhTv8ZGxNuNlqbBE/D/GoRG+xOmCnmCp+
	 SkL+be1fr28zYpU+PKs0f8uYMNBiYmB6n+tCSuFs8ZXQ+vW6+9QfVGNUYJdM8f3ohm
	 TbAUm4Geu9nVLHFq/fWIboRkNWBF5PQxab/8yH5U=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-XMAILINFO: NsBBv6AnqV8OI3/QX3nIJZj1r7X8eahIu/skw6SH9vSihKhR25OifrEEXol7n1
	 r4HExTSXx1mSb6rhV0XzB60Fr09/G4y3xSwbm6WULRAgIV1JR87C0nCRKMsuoTMp3limdMUEjBrC6
	 cS2bHjQXz1acu4N/626G3AmZk+ie9cshOqFD2YFnevtalE68MN1dJZ5eUkFE6/pDrglhLjqDdHwwq
	 FZezy/zvg6LXZg42vb2wO/CzsLYHEKJDVX0c48bfd7WP0ro0A9segzmiwj5jXVik6QlKz0IjS1Gb+
	 REbeafxnK7M7cC9Dn0bpTlWYgounGMNzwe6Pev3Dx7ccqXCMWHaOXkrroQdYjy/nF44YsdxXi8s1/
	 QWVOT7sL5VPS3yL0uRb2gJMYzd3kv5xiToxb5/BPTehF32rNjbaDLRtB41Qnd2J3sEwEnPaLzCkK0
	 CBVY+eIT6LnN/ZnfNyH8cwiCCG54+ie2DRnwT9hnNQbYumEKjSOeNm1WOSdUQJBSDU38W+iC6QO4V
	 XLyfkKUF4+Ccy/pZ94MU301xZy6XsGZrpuLzytdGYR1NUFDI8l0yRiyQJ27heSXGZiI6IJprnk2r6
	 7A03QuCy/KiKIWzhpXSdtIif9XpnD1IZ1cGOutkhhm5M01596TPXDkUqn7lY1Ds84ty9cNuAwiHbM
	 iEq8A7EnWM1P5mlvrKEW2bwstKgaHsDgtzdDMYjVRVZ2cPVAU78f5dib1g+55p969BOWMLH3eGM4+
	 lhnHfFph5ApzIMKjr6SoAFRfczp9/3vdbvW9rQR39RAiTDm4w8lzAMqI/GjWjqay/onwMK5kBNjow
	 V6PL5QmGd6p0k2t9iCuC44z4mAGGuRfHpqEq/JmGUDJeXs18CnH+bWXvuoZ+j6lRVc3BEbepBGBhJ
	 rpsdBIz8kXYsBUwscE+FgFDHFErZQin/ShKB9IpoLrZ7u4nD1rpWIbPj60Wvqmb90sR4ExXZ6Z7ry
	 NGJLw+rEXCtbFq4oUU/Kt8FLlbGJG3crBbQoUD7rIuotS1h+pfbOnCcyvQTpWdDzlxBY5PeebaI6v
	 AzFqYn7HV4aMK+qVYRkHxO/SKffB+o1H4DNaz2PSRMqgB43o=
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
Date: Sat, 12 Jul 2025 15:09:11 +0800
X-Priority: 3
Message-ID: <tencent_06D7B1ACC3E6C74EB95ECB4B119EA37DBE05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
X-QQ-mid: xmsezb29-0t1752304151t80yx6nxn

SGVsbG/CoG9wZW5yaXNjwqBjb21tdW5pdHksCgpJJ23CoGludGVyZXN0ZWTCoGluwqBidWls
ZGluZ8KgdGhlwqBMaW51eMKga2VybmVswqBhbmTCoGJ1c3lib3jCoHJvb3Rmc8KgZm9ywqBP
cGVuUklTQ8Kgb27CoGHCoFdpbmRvd3MvQ3lnd2luwqBlbnZpcm9ubWVudC4KQ291bGTCoGFu
eW9uZcKgYWR2aXNlwqBpZsKgdGhlcmXCoGFyZcKgd29ya2luZ8Kgb3Ixay1lbGbCoGFuZMKg
b3Ixay1saW51eMKgdG9vbGNoYWluc8KgYXZhaWxhYmxlwqBmb3LCoFdpbmRvd3MvQ3lnd2lu
P8KgCkkgY2hlY2tlZCB0aGUgT3BlblJJU0MgZG9jcyBhbmQgdG9vbGNoYWluIHJlcG9zIGJ1
dCBjb3VsZG7igJl0IGZpbmQgV2luZG93cy1zcGVjaWZpY8KgIGd1aWRhbmNlLiBBbnkgcG9p
bnRlcnMgd291bGQgYmUgaGVscGZ1bCEgwqAKCkJlc3TCoHJlZ2FyZHMsCkdhcnkKCgoK

