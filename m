Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OcTKjNRU"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCCF90;
	Fri,  8 Dec 2023 10:25:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F3DC433C8;
	Fri,  8 Dec 2023 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702059908;
	bh=rRbIXqjq8DKBA6vW+7glleky65j8TQodsqrm6IeWtY0=;
	h=Date:From:To:Subject:From;
	b=OcTKjNRUAOx4EuM2hMMliz01h7q89aJAG4PcP7GmEI77tpeHwcO0Btdc4u+5Q9bXY
	 UuU7j57m86CgdE95mJ09SVTkd/Qpa81lS+nR30efCUsRl+YvSWVYH9GLKmISs9syjZ
	 dBkFNJI4GPFrGK8pyCYB1PHGNBf4gnsMu4hqqpvE=
Date: Fri, 8 Dec 2023 13:25:07 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-openrisc@vger.kernel.org, smatch@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231208-primitive-woodoo-beluga-f588ea@meerkat>
Precedence: bulk
X-Mailing-List: linux-openrisc@vger.kernel.org
List-Id: <linux-openrisc.vger.kernel.org>
List-Subscribe: <mailto:linux-openrisc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-openrisc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to the new vger infrastructure. No action is
required on your part and there should be no change in how you interact with
this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K
