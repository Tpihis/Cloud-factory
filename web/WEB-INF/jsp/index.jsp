<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>云智造 - 制造资源优化配置平台</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #1a56db;
            --secondary: #0e2a53;
            --accent: #0ea5e9;
            --light: #f3f4f6;
            --dark: #1f2937;
            --success: #10b981;
            --warning: #f59e0b;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f8fafc;
            color: var(--dark);
            line-height: 1.6;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        /* 导航栏样式 */
        header {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }
        
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 0;
        }
        
        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .logo h1 {
            font-size: 1.8rem;
            font-weight: 700;
            color: var(--primary);
        }
        
        .logo i {
            color: var(--accent);
            font-size: 2rem;
        }
        
        .nav-links {
            display: flex;
            gap: 30px;
        }
        
        .nav-links a {
            text-decoration: none;
            color: var(--dark);
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .nav-links a:hover {
            color: var(--primary);
        }
        
        .auth-buttons {
            display: flex;
            gap: 15px;
        }
        
        .btn {
            padding: 10px 20px;
            border-radius: 6px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        
        .btn-outline {
            border: 2px solid var(--primary);
            color: var(--primary);
            background: transparent;
        }
        
        .btn-outline:hover {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: white;
            border: 2px solid var(--primary);
        }
        
        .btn-primary:hover {
            background-color: #1646b6;
            border-color: #1646b6;
        }
        
        /* Hero 区域样式 */
        .hero {
            background: linear-gradient(135deg, #0e2a53 0%, #1a56db 100%);
            color: white;
            padding: 80px 0;
            position: relative;
            overflow: hidden;
        }
        
        .hero::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><polygon fill="rgba(255,255,255,0.05)" points="0,100 100,0 100,100"/></svg>');
            background-size: 100% 100%;
        }
        
        .hero-content {
            display: flex;
            align-items: center;
            gap: 50px;
            position: relative;
            z-index: 2;
        }
        
        .hero-text {
            flex: 1;
        }
        
        .hero-text h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
            line-height: 1.3;
        }
        
        .hero-text p {
            font-size: 1.1rem;
            margin-bottom: 30px;
            opacity: 0.9;
        }
        
        .hero-image {
            flex: 1;
            display: flex;
            justify-content: center;
        }
        
        .dashboard-preview {
            background: white;
            border-radius: 10px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 500px;
            height: 300px;
            position: relative;
            overflow: hidden;
        }
        
        .dashboard-preview::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 40px;
            background-color: #e5e7eb;
        }
        
        .dashboard-preview::after {
            content: "";
            position: absolute;
            top: 45px;
            left: 20px;
            width: 90%;
            height: 40px;
            background: linear-gradient(90deg, #3b82f6, #60a5fa, #93c5fd, #bfdbfe);
            border-radius: 5px;
        }
        
        .dashboard-grid {
            position: absolute;
            top: 100px;
            left: 20px;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            width: 90%;
        }
        
        .dashboard-cell {
            height: 40px;
            background-color: #f3f4f6;
            border-radius: 4px;
        }
        
        .dashboard-cell:nth-child(1) {
            background-color: #c7d2fe;
        }
        
        .dashboard-cell:nth-child(2) {
            background-color: #a5b4fc;
        }
        
        .dashboard-cell:nth-child(3) {
            background-color: #818cf8;
        }
        
        .dashboard-cell:nth-child(4) {
            background-color: #6366f1;
        }
        
        .dashboard-cell:nth-child(5) {
            background-color: #4f46e5;
        }
        
        .dashboard-cell:nth-child(6) {
            background-color: #4338ca;
        }
        
        /* 平台价值部分 */
        .value-props {
            padding: 80px 0;
            background-color: white;
        }
        
        .section-title {
            text-align: center;
            margin-bottom: 50px;
        }
        
        .section-title h2 {
            font-size: 2.2rem;
            color: var(--secondary);
            margin-bottom: 15px;
        }
        
        .section-title p {
            color: #6b7280;
            max-width: 700px;
            margin: 0 auto;
        }
        
        .props-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .prop-card {
            background-color: var(--light);
            border-radius: 10px;
            padding: 30px;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        
        .prop-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }
        
        .prop-icon {
            background-color: var(--accent);
            color: white;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            font-size: 1.5rem;
        }
        
        .prop-card h3 {
            font-size: 1.4rem;
            margin-bottom: 15px;
            color: var(--secondary);
        }
        
        /* 功能展示部分 */
        .features {
            padding: 80px 0;
            background-color: #f1f5f9;
        }
        
        .features-tabs {
            display: flex;
            gap: 20px;
            margin-bottom: 40px;
            flex-wrap: wrap;
        }
        
        .feature-tab {
            padding: 15px 30px;
            background-color: white;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s;
            border: 2px solid transparent;
        }
        
        .feature-tab.active {
            background-color: var(--primary);
            color: white;
            border-color: var(--primary);
        }
        
        .feature-tab:not(.active):hover {
            border-color: var(--primary);
        }
        
        .feature-content {
            display: none;
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .feature-content.active {
            display: block;
        }
        
        .feature-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }
        
        .feature-item {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }
        
        .feature-icon {
            background-color: rgba(14, 165, 233, 0.1);
            color: var(--accent);
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2rem;
            flex-shrink: 0;
        }
        
        .feature-text h4 {
            margin-bottom: 8px;
            font-size: 1.2rem;
        }
        
        /* 用户角色部分 */
        .user-roles {
            padding: 80px 0;
            background-color: white;
        }
        
        .roles-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
        }
        
        .role-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        
        .role-card:hover {
            transform: translateY(-10px);
        }
        
        .role-header {
            padding: 25px;
            text-align: center;
            color: white;
        }
        
        .role-header h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
        }
        
        .role-header.provider {
            background: linear-gradient(135deg, #0ea5e9, #1d4ed8);
        }
        
        .role-header.consumer {
            background: linear-gradient(135deg, #10b981, #047857);
        }
        
        .role-header.admin {
            background: linear-gradient(135deg, #f59e0b, #b45309);
        }
        
        .role-body {
            padding: 25px;
            background-color: white;
        }
        
        .role-feature {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        
        .role-feature i {
            color: var(--accent);
        }
        
        /* CTA部分 */
        .cta-section {
            padding: 100px 0;
            background: linear-gradient(135deg, #0e2a53 0%, #1a56db 100%);
            color: white;
            text-align: center;
        }
        
        .cta-section h2 {
            font-size: 2.5rem;
            margin-bottom: 20px;
        }
        
        .cta-section p {
            max-width: 700px;
            margin: 0 auto 40px;
            opacity: 0.9;
            font-size: 1.1rem;
        }
        
        .cta-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
        }
        
        .btn-light {
            background-color: white;
            color: var(--primary);
            font-weight: 600;
        }
        
        .btn-light:hover {
            background-color: #f1f5f9;
        }
        
        /* 页脚 */
        footer {
            background-color: var(--secondary);
            color: white;
            padding: 60px 0 30px;
        }
        
        .footer-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            margin-bottom: 40px;
        }
        
        .footer-col h4 {
            font-size: 1.2rem;
            margin-bottom: 20px;
            position: relative;
            padding-bottom: 10px;
        }
        
        .footer-col h4::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 50px;
            height: 2px;
            background-color: var(--accent);
        }
        
        .footer-links {
            list-style: none;
        }
        
        .footer-links li {
            margin-bottom: 12px;
        }
        
        .footer-links a {
            color: #cbd5e1;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .footer-links a:hover {
            color: white;
        }
        
        .footer-bottom {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: #94a3b8;
            font-size: 0.9rem;
        }
        
        /* 响应式设计 */
        @media (max-width: 768px) {
            .hero-content {
                flex-direction: column;
            }
            
            .feature-grid {
                grid-template-columns: 1fr;
            }
            
            .footer-grid {
                grid-template-columns: 1fr 1fr;
            }
        }
        
        @media (max-width: 576px) {
            .nav-links {
                display: none;
            }
            
            .footer-grid {
                grid-template-columns: 1fr;
            }
            
            .cta-buttons {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <%--<header>
        <div class="container">
            <nav class="navbar">
                <div class="logo">
                    <i class="fas fa-industry"></i>
                    <h1>云智造</h1>
                </div>
                <div class="nav-links">
                    <a href="#" class="active">首页</a>
                    <a href="#">资源中心</a>
                    <a href="#">任务中心</a>
                    <a href="#">解决方案</a>
                    <a href="#">关于我们</a>
                </div>
                <div class="auth-buttons">
                    <a href="/auth/loginPage" class="btn btn-outline">登录</a>
                    <a href="#" class="btn btn-primary">免费注册</a>
                </div>
            </nav>
        </div>
    </header>--%>

    <!-- Hero 区域 -->
    <section class="hero">
        <div class="container">
            <div class="hero-content">
                <div class="hero-text">
                    <h2>优化制造资源配置，提升企业协同效率</h2>
                    <p>云智造平台连接制造资源提供方与需求方，通过智能算法实现资源最优配置，降低制造成本，提升生产效率，打造云制造生态系统。</p>
                    <div class="auth-buttons">
                        <a href="/user/resource/display" class="btn btn-light">探索资源</a>
                        <a href="/user/task/addTask" class="btn btn-outline" style="color: white; border-color: white;">发布任务</a>
                    </div>
                </div>
                <div class="hero-image">
                    <div class="dashboard-preview">
                        <div class="dashboard-grid">
                            <div class="dashboard-cell"></div>
                            <div class="dashboard-cell"></div>
                            <div class="dashboard-cell"></div>
                            <div class="dashboard-cell"></div>
                            <div class="dashboard-cell"></div>
                            <div class="dashboard-cell"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 平台价值 -->
    <section class="value-props">
        <div class="container">
            <div class="section-title">
                <h2>云智造平台核心价值</h2>
                <p>通过技术创新解决制造业资源利用率低、协同效率差等关键问题</p>
            </div>
            <div class="props-grid">
                <div class="prop-card">
                    <div class="prop-icon">
                        <i class="fas fa-sync-alt"></i>
                    </div>
                    <h3>资源高效利用</h3>
                    <p>整合闲置制造资源，通过智能匹配算法提升设备、人力、物料等资源利用率，降低企业运营成本。</p>
                </div>
                <div class="prop-card">
                    <div class="prop-icon">
                        <i class="fas fa-handshake"></i>
                    </div>
                    <h3>跨企业协同制造</h3>
                    <p>建立企业间协同机制，实现制造任务分解与分配，促进制造能力共享与互补，提升整体制造效率。</p>
                </div>
                <div class="prop-card">
                    <div class="prop-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <h3>智能优化配置</h3>
                    <p>基于多维评价指标（时间、成本、质量、可靠性）实现资源智能优选，生成最优执行方案。</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 功能展示 -->
    <section class="features">
        <div class="container">
            <div class="section-title">
                <h2>核心功能模块</h2>
                <p>全方位满足制造资源优化配置需求</p>
            </div>
            
            <div class="features-tabs">
                <div class="feature-tab active" data-tab="resource">资源管理</div>
                <div class="feature-tab" data-tab="task">任务管理</div>
                <div class="feature-tab" data-tab="order">订单管理</div>
                <div class="feature-tab" data-tab="data">数据分析</div>
            </div>
            
            <div class="feature-content active" id="resource-content">
                <div class="feature-grid">
                    <div>
                        <div class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-upload"></i>
                            </div>
                            <div class="feature-text">
                                <h4>资源发布</h4>
                                <p>支持设备、人力、软件、物料等资源发布，提供标准化描述模板</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-filter"></i>
                            </div>
                            <div class="feature-text">
                                <h4>资源分类与搜索</h4>
                                <p>按行业、工艺、设备类型分类，支持关键词搜索与高级筛选</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-sync"></i>
                            </div>
                            <div class="feature-text">
                                <h4>资源状态管理</h4>
                                <p>实时更新资源状态（可用/忙碌/维护），系统自动监控使用情况</p>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-shield-alt"></i>
                            </div>
                            <div class="feature-text">
                                <h4>资源审核</h4>
                                <p>平台运维者审核资源信息，确保真实性与合规性</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-star"></i>
                            </div>
                            <div class="feature-text">
                                <h4>资源评价系统</h4>
                                <p>用户可对使用过的资源进行评分和评价</p>
                            </div>
                        </div>
                        <div class="feature-item">
                            <div class="feature-icon">
                                <i class="fas fa-chart-line"></i>
                            </div>
                            <div class="feature-text">
                                <h4>资源利用率分析</h4>
                                <p>可视化展示各类资源使用情况，辅助决策</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- 用户角色 -->
    <section class="user-roles">
        <div class="container">
            <div class="section-title">
                <h2>多角色协同平台</h2>
                <p>为不同用户提供定制化服务</p>
            </div>
            
            <div class="roles-container">
                <div class="role-card">
                    <div class="role-header provider">
                        <h3>资源提供方</h3>
                        <p>制造企业 & 资源拥有者</p>
                    </div>
                    <div class="role-body">
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>发布闲置制造资源（设备、人力、技术）</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>管理资源状态与可用时间</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>接收任务请求与订单通知</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>查看资源使用数据与收益统计</p>
                        </div>
                        <a href="#" class="btn btn-outline" style="margin-top: 20px; width: 100%;">注册成为提供方</a>
                    </div>
                </div>
                
                <div class="role-card">
                    <div class="role-header consumer">
                        <h3>服务需求方</h3>
                        <p>制造任务发布者</p>
                    </div>
                    <div class="role-body">
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>发布制造任务需求与技术要求</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>使用智能任务分解工具</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>获取最优资源配置方案</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>全程监控任务执行状态</p>
                        </div>
                        <a href="#" class="btn btn-outline" style="margin-top: 20px; width: 100%;">发布制造任务</a>
                    </div>
                </div>
                
                <div class="role-card">
                    <div class="role-header admin">
                        <h3>平台运维方</h3>
                        <p>系统管理与运营</p>
                    </div>
                    <div class="role-body">
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>审核资源与任务信息</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>监控平台交易与运行状态</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>管理用户权限与系统模板</p>
                        </div>
                        <div class="role-feature">
                            <i class="fas fa-check-circle"></i>
                            <p>平台数据分析与优化</p>
                        </div>
                        <a href="#" class="btn btn-outline" style="margin-top: 20px; width: 100%;">管理员登录</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA区域 -->
    <section class="cta-section">
        <div class="container">
            <h2>加入云智造平台，开启高效制造新时代</h2>
            <p>无论您是资源提供方、制造需求方还是平台合作伙伴，都能在这里找到价值</p>
            <div class="cta-buttons">
                <a href="#" class="btn btn-light">免费注册</a>
                <a href="#" class="btn btn-outline" style="color: white; border-color: white;">查看演示</a>
            </div>
        </div>
    </section>

    <!-- 页脚 -->
    <footer>
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="logo">
                        <i class="fas fa-industry"></i>
                        <h3>云智造</h3>
                    </div>
                    <p style="margin-top: 20px; color: #cbd5e1; max-width: 350px;">连接制造资源，优化产业配置，提升协同效率，打造智能制造生态系统。</p>
                </div>
                
                <div class="footer-col">
                    <h4>平台功能</h4>
                    <ul class="footer-links">
                        <li><a href="#">资源发布</a></li>
                        <li><a href="#">任务管理</a></li>
                        <li><a href="#">智能匹配</a></li>
                        <li><a href="#">订单系统</a></li>
                        <li><a href="#">数据分析</a></li>
                    </ul>
                </div>
                
                <div class="footer-col">
                    <h4>解决方案</h4>
                    <ul class="footer-links">
                        <li><a href="#">离散制造业</a></li>
                        <li><a href="#">流程制造业</a></li>
                        <li><a href="#">中小制造企业</a></li>
                        <li><a href="#">产业集群</a></li>
                        <li><a href="#">定制化生产</a></li>
                    </ul>
                </div>
                
                <div class="footer-col">
                    <h4>联系我们</h4>
                    <ul class="footer-links">
                        <li><i class="fas fa-envelope"></i> contact@cloudmfg.com</li>
                        <li><i class="fas fa-phone"></i> 400-888-8888</li>
                        <li><i class="fas fa-map-marker-alt"></i> 安徽省合肥市巢湖市巢湖学院</li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>© 2023 云智造平台 版权所有 | 沪ICP备12345678号</p>
            </div>
        </div>
    </footer>

    <script>
        // 功能标签切换
        const tabs = document.querySelectorAll('.feature-tab');
        const contents = document.querySelectorAll('.feature-content');
        
        tabs.forEach(tab => {
            tab.addEventListener('click', () => {
                // 移除所有活动状态
                tabs.forEach(t => t.classList.remove('active'));
                contents.forEach(c => c.classList.remove('active'));
                
                // 添加当前活动状态
                tab.classList.add('active');
                const tabId = tab.getAttribute('data-tab');
                document.getElementById(tabId+'-content').classList.add('active');
            });
        });
    </script>
</body>
</html>