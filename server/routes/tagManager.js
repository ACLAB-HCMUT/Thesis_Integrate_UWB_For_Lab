const tagManager = {
    tags: [],
    lastSeen: {},
    currentIndex: 0,
    isRunning: false,
    intervalMs: 5000,
    TIMEOUT_MS: 15000,
    currentActive: null,
    timeoutMonitor: null,

    start(aedes) {
        if (this.isRunning) return;
        this.isRunning = true;
        console.log("🚀 Bắt đầu quản lý tag...");

        this.rotateTag(aedes);

        setInterval(() => this.cleanupInactiveTags(), 5000);
    },

    rotateTag(aedes) {
        if (this.tags.length === 0) {
            this.currentActive = null;
            return;
        }

        this.currentActive = this.tags[this.currentIndex];
        const message = JSON.stringify({ activeTag: this.currentActive, duration: this.intervalMs });

        aedes.publish({ topic: "uwb/control", payload: message });
        console.log(`📡 Gửi message: uwb/control ${message}`);
        console.log("📢 Cấp quyền cho:", this.currentActive);

        this.printStatus(); // ✅ In trạng thái sau khi cấp quyền

        this.timeoutMonitor = setTimeout(() => {
            console.log(`⏰ Không nhận được timeout từ tag ${this.currentActive}, xoá khỏi danh sách.`);
            this.removeTag(this.currentActive);
            this.nextTag(aedes);
        }, this.TIMEOUT_MS);
    },

    handleRegister(tagId, aedes) {
        const now = Date.now();
        this.lastSeen[tagId] = now;

        if (!this.tags.includes(tagId)) {
            this.tags.push(tagId);
            console.log("✅ Đăng ký tag mới:", tagId);

            if (this.tags.length === 1) {
                this.rotateTag(aedes);
            }

            this.printStatus(); // ✅ In trạng thái sau khi đăng ký tag
        }

        const topic = `uwb/ack/${tagId}`;
        const message = JSON.stringify({ status: "ok" });
        aedes.publish({ topic, payload: message });
        console.log(`📡 Gửi ack đăng ký: ${topic} ${message}`);
    },

    handleTimeoutMessage(tagId, aedes) {
        if (tagId === this.currentActive) {
            console.log(`📥 Nhận timeout từ tag ${tagId}, xác nhận và chuyển tag.`);

            const topic = `uwb/ack/${tagId}`;
            const message = JSON.stringify({ status: "received timeout" });
            aedes.publish({ topic, payload: message });

            clearTimeout(this.timeoutMonitor);
            this.nextTag(aedes);
        } else {
            console.log(`⚠️ Nhận timeout từ tag ${tagId} nhưng không khớp với tag đang hoạt động.`);
        }

        this.printStatus(); // ✅ In trạng thái sau khi nhận timeout
    },

    nextTag(aedes) {
        if (this.tags.length === 0) return;

        this.currentIndex = (this.currentIndex + 1) % this.tags.length;
        setTimeout(() => this.rotateTag(aedes), 100);
    },

    removeTag(tagId) {
        this.tags = this.tags.filter(t => t !== tagId);
        if (this.currentActive === tagId) {
            clearTimeout(this.timeoutMonitor);
            this.timeoutMonitor = null;
            this.currentActive = null;
        }
        delete this.lastSeen[tagId];

        if (this.currentIndex >= this.tags.length) {
            this.currentIndex = 0;
        }

        console.log(`🧹 Đã xóa tag ${tagId} khỏi danh sách.`);
        this.printStatus(); // ✅ In trạng thái sau khi xoá tag
    },

    cleanupInactiveTags() {
        const now = Date.now();
        this.tags = this.tags.filter((tag) => {
            const lastTime = this.lastSeen[tag] || 0;
            const isActive = now - lastTime < this.TIMEOUT_MS;

            if (!isActive) {
                console.log("🗑️ Tự xoá tag không hoạt động:", tag);
                delete this.lastSeen[tag];
            }

            return isActive;
        });

        if (this.currentIndex >= this.tags.length) {
            this.currentIndex = 0;
        }

        this.printStatus(); // ✅ In trạng thái sau khi cleanup
    },

    printStatus() {
        console.log("========== 🧭 Trạng thái TagManager ==========");
        console.log("📋 Danh sách tags:", this.tags);
        console.log("🕒 Last seen:", this.lastSeen);
        console.log("🔢 currentIndex:", this.currentIndex);
        console.log("⚙️ isRunning:", this.isRunning);
        console.log("⏱️ intervalMs:", this.intervalMs);
        console.log("⏳ TIMEOUT_MS:", this.TIMEOUT_MS);
        console.log("🎯 currentActive:", this.currentActive);
        console.log("🧨 timeoutMonitor:", this.timeoutMonitor ? 'Đang chạy' : 'Không có');
        console.log("===============================================");
    }
};

module.exports = tagManager;
