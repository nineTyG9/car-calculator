-- ========== 配置表：存储密码 ==========
CREATE TABLE config (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL
);

INSERT INTO config (key, value) VALUES
  ('password', '123456'),
  ('auth_password', 'admin888');

-- ========== 使用次数表 ==========
CREATE TABLE usage_logs (
  date_key TEXT PRIMARY KEY,
  count INTEGER DEFAULT 1,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ========== 允许公开读写 ==========
ALTER TABLE config ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_config" ON config FOR SELECT USING (true);

ALTER TABLE usage_logs ENABLE ROW LEVEL SECURITY;
CREATE POLICY "public_read_usage" ON usage_logs FOR SELECT USING (true);
CREATE POLICY "public_insert_usage" ON usage_logs FOR INSERT WITH CHECK (true);
CREATE POLICY "public_update_usage" ON usage_logs FOR UPDATE USING (true);
