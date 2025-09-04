Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58192F83BC;
	Thu,  4 Sep 2025 10:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756980097; cv=none; b=O7stb7iTF4JShKmpGHyHCeCRbxpIU1rtPfnjiSgqfK7Loy1B2FvlzwJkwpRF9BaQQ8YrEOebxUnweMqjuiRw/U2kM8Cia8Hx2UkFM+ImqXxkY785ULHNfca9+HoAvvIbLK6uxpDP2qK2eC5anOFEeXMgCIOIT57CtyUvQjBPSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756980097; c=relaxed/simple;
	bh=PsVd6C4psph+e1gqARopkSzWhgv+MiZt61T+Lfmzr0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXdeprr7iBxyORGIH1hGavweER4QCFTxTpowkDJ/7g2uPSpSJLMxvZJD6EW6qyHohhlKLcNO0HRwMvA/0d2Yq5B1xBR0fxlk2u5bAp8Y8pGeWnyRUgKfzy8jiZ9tRhQwtICItCksccwFEsFx5jPYuLzTVBbvDWKgvrjI34AtwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hYoeHyYo; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYoeHyYo"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-772627dd50aso2195966b3a.1;
        Thu, 04 Sep 2025 03:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756980095; x=1757584895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9IQSACqPH+hbfEranj10Cab4WP4xbeC5eLzb0sRCnw=;
        b=hYoeHyYouPHGsiUZuHEg6ccFt5/v6JrO+5ZEBy3y5HS1ijWfaW5wt40cnkLmeL2jsG
         vBuoRX+cDC1rb0d+H+5bm5uZcdLFAo4Hs3OYeIjIhb1c0vtxIcZ/AoxPzPORTLEbwypT
         +N1EualeNHYPO4GisKAwGWNCoow25goBOFbREGWYWreiyZ7LbWg0LCbzu+Oezxxo2hX1
         zMdzUKhJ4sYB41gWO07Lp09xmG43CcNrP1cp6S7XPk5H83N8UyYwy6xUjNe3KckvlJVZ
         VmhYhXyQmp1jMNUWEpEBgyyR93JGVM1Mh6ufjkpdI41p1RGk4M1JdHnZIRSURqc8GX4m
         kjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756980095; x=1757584895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9IQSACqPH+hbfEranj10Cab4WP4xbeC5eLzb0sRCnw=;
        b=gssUp01BIWhKzX2gLNF70wA6hPD59n7Hus8BnAN5FEyb2dtSxOCDfFzKBULWCrAQy8
         CD2oJskoFiteQyxz9BwLi6Y8vAtK/KPbO/xRs6LMcMNlMUp+UIoXKA9XzKv4KHJ2PJsb
         UTiWiVXLFCGilSXt//eHxgSIMhIs5Mvwbpb8o1u7P7Z+zZ+6r1XqENfYIM6vKsMdkhLp
         HohnIsNlty7azynrJ3UKIetV1Nx8MD+qEdoecccZ3Q+zckEOEYEyzPj72OOxlX8McaRR
         0hOs8VbDsIQ++29EL8+EXBUPafkrOLxtHQtDp9E0bfJkunNiYQPN9lQnqwn+PJhlBdjI
         Bcmw==
X-Forwarded-Encrypted: i=1; AJvYcCVs3iLNnn4k3SvCBJ2fzE+ROv87NUHJBLtLnQ3tm+aS07h//NUYD5JfS+eACntI9H3HhRwKgOGNaUu70lxrew==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb9DOrglzD2BgLqPDLX8qw0011TZIZVVQKRgK7k2VuvVA4loTl
	soLESeAlLeRnWpP83kGGM6Qgn0bCuNo8KIqhFfd4D/11YFVBmnn461fft7rbfIhlYnghwg==
X-Gm-Gg: ASbGncvciwXLQ9DMUA2ztR54fkJllGFcVV6nAGuB1A5YxMBrDuxEnFTYiXPqT45cjbT
	Q50M2gBOBVCXotOM6y8529NlRrgoUKUNU31dyHhxdawfrwiDGbWvHVxqZzFdnjJDFlzu1gwpsCe
	XCtkk9EvCVfoKggfeNDuL4xb+9LZb2Trhl0bRlUyUnqp5cHr27L24IeXCwAmsT+cyF3R91lbu34
	bAKRm24sN39zX0oJrvokZh/J850QTAB4rTuqvBttJyniSBkjttKQl1OqlZfhF9qXnIcITceE5BM
	Bl8803/2JK95eGq7viP0loj421Xp3GhobhndPPkImQTbjjJsvKpJXobOaT+sA/wHm2+OOuZ+iSV
	W4Ee2qjGNh6QdDu0yVe3NFtCd2gaueDd9oK05o+K6ZA3ps01nBOY=
X-Google-Smtp-Source: AGHT+IHzQMj8c5qJHFR/gXnIa+VhPovTRzVcLhcra+3HhxRfU2Ln+KtDiVxVHnWN0JdyMq1sCbQJyA==
X-Received: by 2002:a05:6a20:938c:b0:246:5be:ca90 with SMTP id adf61e73a8af0-24605becdb2mr9234751637.10.1756980094729;
        Thu, 04 Sep 2025 03:01:34 -0700 (PDT)
Received: from nyaos.. (v133-18-108-210.vir.kagoya.net. [133.18.108.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b747c2d66sm3510656a91.28.2025.09.04.03.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 03:01:33 -0700 (PDT)
From: ChenMiao <chenmiao.ku@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>,
	Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc: chenmiao <chenmiao.ku@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>
Subject: [PATCH v4 2/4] openrisc: Add R_OR1K_32_PCREL relocation type module support
Date: Thu,  4 Sep 2025 10:00:50 +0000
Message-ID: <20250904100109.688033-3-chenmiao.ku@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250904100109.688033-1-chenmiao.ku@gmail.com>
References: <20250904100109.688033-1-chenmiao.ku@gmail.com>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chenmiao <chenmiao.ku@gmail.com>

To ensure the proper functioning of the jump_label test module, this patch
adds support for the R_OR1K_32_PCREL relocation type. The implementation
calculates the PC-relative offset by subtracting the instruction location
from the target value and stores the result at the specified location.

Signed-off-by: chenmiao <chenmiao.ku@gmail.com>
---
 arch/openrisc/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/openrisc/kernel/module.c b/arch/openrisc/kernel/module.c
index c9ff4c4a0b29..4ac4fbaa827c 100644
--- a/arch/openrisc/kernel/module.c
+++ b/arch/openrisc/kernel/module.c
@@ -55,6 +55,10 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			value |= *location & 0xfc000000;
 			*location = value;
 			break;
+		case R_OR1K_32_PCREL:
+			value -= (uint32_t)location;
+			*location = value;
+			break;
 		case R_OR1K_AHI16:
 			/* Adjust the operand to match with a signed LO16.  */
 			value += 0x8000;
-- 
2.45.2

