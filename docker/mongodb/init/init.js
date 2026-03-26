db = db.getSiblingDB('devops_db');

db.createCollection('users');

db.users.insertMany([
  { name: 'Антон', role: 'DevOps Engineer', skills: ['Docker', 'K8s', 'Ansible'] },
  { name: 'Иван', role: 'Backend Developer', skills: ['Node.js', 'Python'] },
  { name: 'Мария', role: 'Frontend Developer', skills: ['React', 'Vue'] }
]);

print('✅ База данных инициализирована!');
