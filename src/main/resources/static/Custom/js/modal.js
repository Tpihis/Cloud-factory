// modal.js - 可复用弹框组件
class Modal {
    /**
     * 创建弹框实例
     * @param {Object} options 配置选项
     * @param {string} options.title 弹框标题
     * @param {string} options.content 弹框内容(HTML)
     * @param {string} [options.confirmText='确认'] 确认按钮文字
     * @param {string} [options.cancelText='取消'] 取消按钮文字
     * @param {Function} [options.onConfirm] 确认回调
     * @param {Function} [options.onCancel] 取消回调
     * @param {Array} [options.buttons] 自定义按钮数组
     */
    constructor(options = {}) {
        this.defaultOptions = {
            title: '提示',
            content: '',
            confirmText: '确认',
            cancelText: '取消',
            onConfirm: null,
            onCancel: null,
            buttons: null,
            // 新增输入框配置
            input: false,               // 是否显示输入框
            inputType: 'text',          // 输入框类型(text/password/email等)
            inputPlaceholder: '',       // 输入框占位符
            inputValue: '',             // 输入框默认值
            inputRequired: false,       // 是否必填
            inputAttributes: {}         // 额外的input属性
        };

        this.options = {...this.defaultOptions, ...options};
        this.createModal();
    }

    createModal() {
        this.overlay = document.createElement('div');
        this.overlay.className = 'C-modal-overlay';

        this.modal = document.createElement('div');
        this.modal.className = 'C-modal-container';

        // 标题栏
        const header = document.createElement('div');
        header.className = 'C-modal-header';
        header.textContent = this.options.title;

        // 内容区域
        const body = document.createElement('div');
        body.className = 'C-modal-body';

        // 添加输入框（如果配置了input）
        if (this.options.input) {
            this.inputElement = document.createElement('input');
            this.inputElement.type = this.options.inputType;
            this.inputElement.placeholder = this.options.inputPlaceholder;
            this.inputElement.value = this.options.inputValue;
            this.inputElement.className = 'C-modal-input';

            // 添加额外属性
            Object.keys(this.options.inputAttributes).forEach(attr => {
                this.inputElement.setAttribute(attr, this.options.inputAttributes[attr]);
            });

            const inputContainer = document.createElement('div');
            inputContainer.className = 'C-modal-input-container';
            inputContainer.appendChild(this.inputElement);
            body.appendChild(inputContainer);
        }

        // 添加自定义内容
        if (this.options.content) {
            const contentDiv = document.createElement('div');
            contentDiv.className = 'C-modal-content';
            contentDiv.innerHTML = this.options.content;
            body.appendChild(contentDiv);
        }

        // 底部按钮区域
        const footer = document.createElement('div');
        footer.className = 'C-modal-footer';

        if (Array.isArray(this.options.buttons)) {
            this.options.buttons.forEach(btn => {
                const button = document.createElement('button');
                button.className = `C-modal-btn ${btn.className || ''}`;
                button.textContent = btn.text;
                button.addEventListener('click', () => {
                    const inputValue = this.options.input ? this.inputElement.value : null;
                    if (typeof btn.handler === 'function') {
                        btn.handler(inputValue);
                    }
                    this.hide();
                });
                footer.appendChild(button);
            });
        } else {
            if (this.options.cancelText) {
                this.cancelBtn = document.createElement('button');
                this.cancelBtn.className = 'C-modal-btn C-modal-btn-cancel';
                this.cancelBtn.textContent = this.options.cancelText;
                this.cancelBtn.addEventListener('click', () => {
                    if (typeof this.options.onCancel === 'function') {
                        const inputValue = this.options.input ? this.inputElement.value : null;
                        this.options.onCancel(inputValue);
                    }
                    this.hide();
                });
                footer.appendChild(this.cancelBtn);
            }

            if (this.options.confirmText) {
                this.confirmBtn = document.createElement('button');
                this.confirmBtn.className = 'C-modal-btn C-modal-btn-confirm';
                this.confirmBtn.textContent = this.options.confirmText;
                this.confirmBtn.addEventListener('click', () => {
                    if (this.options.input && this.options.inputRequired && !this.inputElement.value.trim()) {
                        this.inputElement.focus();
                        return;
                    }

                    if (typeof this.options.onConfirm === 'function') {
                        const inputValue = this.options.input ? this.inputElement.value : null;
                        const result = this.options.onConfirm(inputValue);
                        if (result !== false) this.hide();
                    } else {
                        this.hide();
                    }
                });
                footer.appendChild(this.confirmBtn);
            }
        }

        this.modal.appendChild(header);
        this.modal.appendChild(body);
        this.modal.appendChild(footer);
        this.overlay.appendChild(this.modal);
        document.body.appendChild(this.overlay);

        this.overlay.addEventListener('click', (e) => {
            if (e.target === this.overlay) {
                this.hide();
            }
        });
    }

    show() {
        this.overlay.classList.add('active');
        if (this.options.input && this.inputElement) {
            setTimeout(() => this.inputElement.focus(), 100);
        }
        return this;
    }

    hide() {
        this.overlay.classList.remove('active');
        setTimeout(() => {
            if (this.overlay && this.overlay.parentNode) {
                document.body.removeChild(this.overlay);
            }
        }, 300);
    }

    // 新增方法：获取输入值
    getInputValue() {
        return this.inputElement ? this.inputElement.value : null;
    }
}

// 添加默认样式
const style = document.createElement('style');
style.textContent = `
/* 新增输入框样式 */
.C-modal-input-container {
    margin: 15px 0;
    width: 100%;
}

.C-modal-input {
    width: 100%;
    padding: 10px 12px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 14px;
    box-sizing: border-box;
    transition: border-color 0.3s;
}

.C-modal-input:focus {
    border-color: #3498db;
    outline: none;
    box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
}

 /* 弹框遮罩层 */
.C-modal-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
    opacity: 0;
    transition: opacity 0.3s ease;
    pointer-events: none;
}

.C-modal-overlay.active {
    opacity: 1;
    pointer-events: all;
}

/* 弹框主体 */
.C-modal-container {
    width: 420px;
    max-width: 90%;
    max-height: 80vh;
    background-color: #f8f9fa;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
    transform: translateY(-20px);
    transition: transform 0.3s ease;
    display: flex;
    flex-direction: column;
}

.C-modal-overlay.active .C-modal-container {
    transform: translateY(0);
}

/* 弹框标题栏 - 蓝色部分 */
.C-modal-header {
    background: linear-gradient(135deg, #3498db, #1a56db);
    color: white;
    padding: 12px 20px;
    font-size: 16px;
    font-weight: 600;
    flex-shrink: 0;
}

/* 弹框内容区域 - 主要空间 */
.C-modal-body {
    text-align: center;
    font-size: larger;
    padding: 25px 20px;
    color: #333;
    line-height: 1.6;
    overflow-y: auto;
    flex-grow: 1;
    border-bottom: 1px solid #eee;
}

/* 弹框底部按钮区域 */
.C-modal-footer {
    display: flex;
    justify-content: flex-end;
    padding: 12px 20px;
    background-color: #f8f9fa;
    flex-shrink: 0;
}

/* 按钮样式 */
.C-modal-btn {
    padding: 8px 18px;
    border-radius: 4px;
    border: none;
    cursor: pointer;
    font-size: 14px;
    margin-left: 12px;
    transition: all 0.2s ease;
    min-width: 80px;
}

.C-modal-btn-confirm {
    background-color: #3498db;
    color: white;
}

.C-modal-btn-confirm:hover {
    background-color: #2980b9;
}

.C-modal-btn-cancel {
    background-color: #e9ecef;
    color: #495057;
    border: 1px solid #dee2e6;
}

.C-modal-btn-cancel:hover {
    background-color: #dee2e6;
}

/* 内容区域滚动条样式 */
.C-modal-body::-webkit-scrollbar {
    width: 6px;
}

.C-modal-body::-webkit-scrollbar-thumb {
    background-color: rgba(0, 0, 0, 0.2);
    border-radius: 3px;
}

.C-modal-body::-webkit-scrollbar-track {
    background-color: transparent;
}
`;
document.head.appendChild(style);

// 导出Modal类
if (typeof module !== 'undefined' && module.exports) {
    module.exports = Modal;
} else if (typeof define === 'function' && define.amd) {
    define([], function() {
        return Modal;
    });
} else {
    window.Modal = Modal;
}