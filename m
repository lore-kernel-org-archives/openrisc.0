Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532112036E0
	for <linux-openrisc@vger.kernel.org>; Thu, 10 Apr 2025 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288123; cv=none; b=OLRGegKZHxJMpPB5dZ+P23IAoXZsw6WvHDOYtnlF2KdLYsJHowI5yEZt8YuVW7AYxWk7mmCCstg3ooL4ATL2iSONjEPuII41ZiCWtDBsRkkHfXiuLNr7+RF9ROOhZI1nd6nKrxm9QLDzSUbCHQS8o1c2YAlBCAycVZcggQNlGAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288123; c=relaxed/simple;
	bh=szmKlrtU1BFfGnb30WxLY9gF0BRo1IeUYdVGDbvg7ws=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=q9j74vy2DJ5YXVqL23NDxrn6rOtP/6apH7eILK6iokSQIMW5v+yfB08x3z9jxC3YOxLgDnKW3L7lh6dhd79NWRINtOpusSOvXKjqdFrnjQSoiml7LMqVHDK01nNWh9zGVl6xZFWLjvAJ/4rhM3ozOOUsctJ50YYz1oqG2q4mihY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmpd5xff; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmpd5xff"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac29fd22163so128202766b.3
        for <linux-openrisc@vger.kernel.org>; Thu, 10 Apr 2025 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744288120; x=1744892920; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=szmKlrtU1BFfGnb30WxLY9gF0BRo1IeUYdVGDbvg7ws=;
        b=cmpd5xffxo2lkb7bL72tNWQq9E41SGTLEWIdIvFXluDYTQo/bMj1oZ4z/qSyNlOd3C
         gXvYBq62qGyBZWQanSjpRiWQBeLi8axI0NDf3o1V9RXw8duooc7O8BKzWDHH3NzQ3FCJ
         5h62aIm9nYs+ROCZj1JAfNcQBDN+OFlRhT1097tYICBaEXHem6/iYn2izS0Ty7e3bVrV
         zab4vZteOxEQScbzDa9bYyfPPqoGFz7Le4iqgv209rRcVP8zzE3KOCOlc5npJB29ca88
         erJQq3UW0DTwR2CVM43/UDU4LS7MINHQzKZ7+SrAi/OH/1ZTaE2CR05sVdQNgSDV/38n
         +bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288120; x=1744892920;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szmKlrtU1BFfGnb30WxLY9gF0BRo1IeUYdVGDbvg7ws=;
        b=J5CV4fx8bVo1x8g0VW3nbhI6jHKXggFA+Ub8sHKTmodrjODxRek0A4bQKio3Ur4QLQ
         e4MKd5ozn+yXkdlkh0r6PmG3eqORnKGHaUNCied1LNZc4myJVXydQMHUWtufAbtZJ+Al
         3JLYg2NPBNqE8A+lRe3jtlerhjMSGqnnADKHMhVYcXXqiUqku1CWVY5DQ0UIT3e8L7HS
         ZcYP9nkXGDtjQZZPFAASQTno+EGIS0XvdzKmTp7/fNdN+xZzEywrjj2O0A7+EexhUNwP
         5Ah4kQIFHpey42rxFAZZpU4u67OEmQt0IYPy/MzOi+xytYFWLMkOIBuZISh/DOjur5Xb
         ut9g==
X-Gm-Message-State: AOJu0YzcTmNjNk7cCI/Y4kazbaYlyWm31u9V5iHI8z3WN5XuCPzGwL/f
	Q/9Kn1a/FvCht7VhQIgXeMYv/DEcl+ne50vLdpcZ/wFeRKVYRGUtYVlJ9MraXrLSvhjLSRYM4Bf
	BHa9XKMXd9PdG3WSKt5dGIeTuboIJU9oEZaU=
X-Gm-Gg: ASbGncshH0r7luOTLeq1NWS6YNvxfgQPVmEZWMF0maVwXlseTZ6y1xl46pXJazpARlk
	z7BunUIc1Mm28HF30dTPnRlHNLRgUyuUh3G2IDinNZRCpOi2oAIKw/9WMm+oLMltNDkktKtU19B
	jH08nUcLirX6sFi5Ot359FEEY=
X-Google-Smtp-Source: AGHT+IG00cWD+w7vMwqsv/s+fkvz49FGc1rp2y6Vu1soEflq09in88jNnt4EEXTKeWcKkFENm6bRM5G/CjAwGDBUjpo=
X-Received: by 2002:a17:907:7208:b0:ac2:dfcf:3e09 with SMTP id
 a640c23a62f3a-acac011664bmr184440366b.43.1744288120190; Thu, 10 Apr 2025
 05:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miao Chen <chenmiao.ku@gmail.com>
Date: Thu, 10 Apr 2025 20:28:28 +0800
X-Gm-Features: ATxdqUFR-UfLVKXzC3vXF6ZsppaG-K0JiD1RxRmMcjEiqfIgK8uWbaCVRaia618
Message-ID: <CAKxVwgeso4VhM4Yezw0+EaJ2m35zXo9GkMVXg0C=DfB237C5uw@mail.gmail.com>
Subject: 
To: linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subcribe linux-openrisc
