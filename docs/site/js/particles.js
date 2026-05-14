class ParticleSystem {
    constructor(container) {
        this.container = container;
        this.particles = [];
        this.mouseX = 0;
        this.mouseY = 0;
        this.init();
    }
    
    init() {
        this.createParticles();
        this.bindEvents();
        this.animate();
    }
    
    createParticles() {
        const particleCount = window.innerWidth < 768 ? 30 : 60;
        
        for (let i = 0; i < particleCount; i++) {
            const particle = document.createElement('div');
            particle.className = 'particle';
            
            const size = Math.random() * 6 + 2;
            const x = Math.random() * 100;
            const y = Math.random() * 100;
            const duration = Math.random() * 20 + 10;
            const delay = Math.random() * 10;
            const opacity = Math.random() * 0.5 + 0.1;
            
            particle.style.cssText = `
                position: absolute;
                width: ${size}px;
                height: ${size}px;
                background: linear-gradient(135deg, rgba(14, 165, 233, 0.6), rgba(139, 92, 246, 0.6));
                border-radius: 50%;
                left: ${x}%;
                top: ${y}%;
                opacity: ${opacity};
                animation: particleFloat ${duration}s ease-in-out ${delay}s infinite;
                pointer-events: none;
            `;
            
            this.container.appendChild(particle);
            this.particles.push({
                element: particle,
                x: x,
                y: y,
                speedX: (Math.random() - 0.5) * 0.5,
                speedY: (Math.random() - 0.5) * 0.5,
                baseX: x,
                baseY: y
            });
        }
    }
    
    bindEvents() {
        document.addEventListener('mousemove', (e) => {
            this.mouseX = (e.clientX / window.innerWidth) * 100;
            this.mouseY = (e.clientY / window.innerHeight) * 100;
        });
    }
    
    animate() {
        this.particles.forEach((particle, index) => {
            const dx = this.mouseX - particle.baseX;
            const dy = this.mouseY - particle.baseY;
            const distance = Math.sqrt(dx * dx + dy * dy);
            
            if (distance < 20) {
                const angle = Math.atan2(dy, dx);
                const force = (20 - distance) / 20;
                particle.x = particle.baseX - Math.cos(angle) * force * 5;
                particle.y = particle.baseY - Math.sin(angle) * force * 5;
            } else {
                particle.x += (particle.baseX - particle.x) * 0.02;
                particle.y += (particle.baseY - particle.y) * 0.02;
            }
            
            particle.element.style.left = particle.x + '%';
            particle.element.style.top = particle.y + '%';
        });
        
        requestAnimationFrame(() => this.animate());
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const particlesContainer = document.getElementById('particles');
    if (particlesContainer) {
        new ParticleSystem(particlesContainer);
    }
});
