/*

/!**
 * 显示Toast提示
 * @param {string} message - 要显示的消息内容
 * @param {string} [type='success'] - 提示类型 ('success'或'error')
 * @param {number} [duration=2000] - 显示持续时间(毫秒)
 *!/
function showToast(message, type = 'success', duration = 2000) {
    // 移除旧的toast
    const oldToast = document.getElementById('custom-toast');
    if (oldToast) oldToast.remove();

    // 创建toast元素
    const toast = document.createElement('div');
    toast.id = 'custom-toast';
    // toast.className = `toast show align-items-center text-white bg-${type === 'error' ? 'danger' : 'success'}`;
    toast.className = 'toast show align-items-center text-white bg-' + (type === 'error' ? 'danger' : 'success');
    toast.style.position = 'fixed';
    toast.style.top = '20px';
    toast.style.right = '20px';
    toast.style.zIndex = '9999';
    toast.style.minWidth = '250px';


    toast.innerHTML = '<div class="d-flex">' +
        '<div class="toast-body">' + message + '</div>' +
        '<button type="button" class="btn-close btn-close-white me-2 m-auto"' +
        'onclick="document.getElementById(\'custom-toast\').remove()"></button>' +
        '</div>';

    document.body.appendChild(toast);

    // 自动消失
    setTimeout(() => toast.remove(), duration);
}

// 可选：导出为全局函数
if (typeof window !== 'undefined') {
    window.showToast = showToast;
}*/
function showToast(message, type = 'success', duration = 2000) {
    // 获取或创建 toast 容器
    let container = document.getElementById('custom-toast-container');
    if (!container) {
        container = document.createElement('div');
        container.id = 'custom-toast-container';
        container.className = 'toast-container';
        document.body.appendChild(container);
    }

    // 创建 toast 元素
    const toast = document.createElement('div');
    toast.className = `toast show align-items-center text-white bg-${type === 'error' ? 'danger' : 'success'}`;

    toast.innerHTML = `
        <div class="d-flex justify-content-between align-items-center">
            <div class="toast-body">${message}</div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" 
                onclick="this.closest('.toast').classList.add('fade-out')"></button>
        </div>
    `;

    // 添加到容器中
    container.appendChild(toast);

    // 设置自动移除
    setTimeout(() => {
        toast.classList.add('fade-out');
        toast.addEventListener('transitionend', () => {
            toast.remove();
            // 如果容器为空则移除
            if (container.children.length === 0) {
                container.remove();
            }
        });
    }, duration);
}

if (typeof window !== 'undefined') {
    window.showToast = showToast;
}
