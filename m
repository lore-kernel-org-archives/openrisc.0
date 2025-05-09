Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57CC23E342
	for <linux-openrisc@vger.kernel.org>; Fri,  9 May 2025 20:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820988; cv=none; b=EJIarUKXNFOrylmmGvJiuBjaZh8gtMKk6Kynm8KCQWBXJ9Umq49eGZE+zzi1nATWgnPGA86SINd1wnOtJfkFKjzboNuOojXxs8g5S50ZNLZz4AHGiiqk25F6CknQY5IEwIC1JgpnFDLTr4qp3ZOmjrJz8CYKGGcmZzIqcZX7VfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820988; c=relaxed/simple;
	bh=LldgAUgTg2+ACzwoRjtYB/169ipfLldA273Eyyqcf3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uOphwCYgaqkNjXpIusEHBivsCk2tr8Yyjj5MZYlLsbda2Xf//L6810DyI0Lk6MbpBd/4jEU06NYN1K/27y1LKeOWME/LbQDc5xRtB0vf+G2lTmIRMafGwxXZOpYYKmG30nOmoG01DBRZl9S4nuclyRHeLHhNIL7aCWiNJVTlMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e51ViMCW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e51ViMCW"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-441d1ed82dbso23601605e9.0
        for <linux-openrisc@vger.kernel.org>; Fri, 09 May 2025 13:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820984; x=1747425784; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WlJRtz9bL20MUWT23/iqTkDKAlM+0qxWzFJtRIJezKM=;
        b=e51ViMCWdBNhaPE4GreLblFhRxkhnTNHeBFz1l7MS8D0DhOxSJCGM6dNzs00X40NiN
         4x+4bx2JS3ztYA5JtkoGFydpvZFYtAZLP3GE/EkaOCH1yFXViNCx6JTE113kBzCTF4vn
         bRbxdYq269YNGHoWXSWnpquL9TGHLpnf7NrcKnQQo/0rPHcfqvsx2klHqMfo0QK4cBfr
         /zGj/ChjEa9mkTPY6PZP0ju/FbcwGLwfgbJT27GdcVBJ/IAzXb6R9KG65cB0gMWaB/Pb
         qtzUwO037B1HqGA/3sJrilPsdbPd4kUZrr2+uX12VqZOP4+p/ARIi2u4/UL9N0sabXiP
         5oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820984; x=1747425784;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WlJRtz9bL20MUWT23/iqTkDKAlM+0qxWzFJtRIJezKM=;
        b=kRwQySTHqJu+Dwnu2vzfOtuM6b15wzxWRaankWlN/ZAQs/6y0NaChNVIsAAnXqA8H4
         xx3JjcO9Bzs96LfkFqGfWQJ4bimOj53gBF4tQo7AtVSFZ3T+IoF+v825Vj2v3qmRX5dT
         wr63gTBgJWFE/XMKOB/0fK1QVZxxAnNDoIUIdx6MR25O9O0ovwVW2yDRxX6m2Rufhbk/
         0D3pnMyBpOfmtpKnUPq7LilgxR5ikh5gxD7BXUu8BHtwm+H6jPvp1l6aZumHpXU+VujD
         9hrzUXS2l7zPT0agFsUtOBI2Ocmh3HngFi5PSoGRkJTQEzUw6gx3eIHuAQbFfGJhm4nF
         x6FA==
X-Gm-Message-State: AOJu0YywTXb/KPBx9+qfZK0Odr+fhbMr97QGBeYS9KsMhHspug40QoYh
	SWOeXI91yemDqvgQ2Ztdg6oxgb4lieKB0USZwBvDHzSNenXUb8AMpaP9pw==
X-Gm-Gg: ASbGncvdF9jElE2EYoOP9jmE2GewUkI5FEiaE7ZzdHODWWnlhWQLzOzfYgsCloWrgn8
	Nu+cJ+AMZ8+Jptl3ABlf+3qC500zxPpBONtIOUBzNqddyepI9AkhWibapafwF4JOIHwTbjj2U/B
	06iR9oFvGIjiPOiyXnOZw4X5cY0o4juWnJT9ty1OLgJnwaND5pE8Z5wRhewrOOpZHySKRs1o8pF
	EuFw2KvnxkkUIPAGu6aw7oM5qRfotCvLtNCLwJNmY+uijgwfX3F9BBwkRzIe2/vetAuWeNXLry8
	pDTvkOzYRqJ0XOSz+tZUqoKJLtFzbADjwDGKF5QDC9kQsImmd/ZpEYVSLUuUljAURVxItxHfLBK
	pe1rtGqXEuANqKY8=
X-Google-Smtp-Source: AGHT+IGgDNQw+fYKns+NJcOMVzrMplEBjviqchB10Y5Xz7MwMKOFiEYOO7r9jilofCUu4PQZkNu0fw==
X-Received: by 2002:a05:600c:8115:b0:441:b00d:e9d1 with SMTP id 5b1f17b1804b1-442d6d08cabmr44406785e9.2.1746820983829;
        Fri, 09 May 2025 13:03:03 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687adc0sm39259665e9.35.2025.05.09.13.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 13:03:02 -0700 (PDT)
Date: Fri, 9 May 2025 21:03:01 +0100
From: Stafford Horne <shorne@gmail.com>
To: Linux OpenRISC <linux-openrisc@vger.kernel.org>
Cc: Sahil Siddiq <icegambit91@gmail.com>, Miao Chen <chenmiao.ku@gmail.com>
Subject: GSoC 2025 OpenRISC Linux Feature Development
Message-ID: <aB5fdVgEiVZ4XsLw@antec>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi All,

Congratulations to Chen Miao for being selected as this year's google summer of
code [0] contributor under the OpenRISC project.

This project will have the contributor developing, testing and sending patches up to
the Linux kernel.

The OpenRISC Linux kernel support is under constant development but there are
certain Linux facilities that are not yet used or available on the OpenRISC
platform.

The project will be to work on:

 - Add tracing facilities to OpenRISC Linux including: jump_label, ftrace,
   kprobes, eBPF etc.

Options include:

 - Convert OpenRISC to use common-entry framework
 - Virtually mapped stacks [1]
 - VDSO support

Please welcome be in welcoming Chen Miao.

-Stafford

[0] https://summerofcode.withgoogle.com
[1] https://www.youtube.com/watch?v=kmMGdSVDVuQ
