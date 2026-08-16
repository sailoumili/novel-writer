/**
 * novel-writer — DeepSeek Harness (DSH) 预设插件。
 *
 * 作用：每次 DSH 启动（加载本插件）时，把包内自带的 agent.cordis.yml 和
 * preset.yml 复制到 DSH 的预设目录（~/.dsh/.agent-presets/novel-writer/，
 * 支持 $DSH_HOME 覆盖），从而注册「多核协同写作模式」预设。
 *
 * 注意：只在目标文件【不存在】时才落地——绝不覆盖你本机改过的预设。
 */
import { mkdir, copyFile } from "node:fs/promises";
import { constants } from "node:fs";
import { homedir } from "node:os";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

/** Cordis 插件名（须与 cordis.patch.yml 里的 id 一致）。 */
const name = "novel-writer";

/** 本文件所在目录（<包>/lib）。 */
const here = dirname(fileURLToPath(import.meta.url));

/** 预设文件在包根目录（lib/ 的上一级）。 */
const SOURCE_DIR = join(here, "..");

/** DSH 主目录：优先 $DSH_HOME，否则 ~/.dsh。 */
function dshHome() {
  return process.env.DSH_HOME ?? join(homedir(), ".dsh");
}

/** 目标目录：DSH 的预设目录。 */
function targetDir() {
  return join(dshHome(), ".agent-presets", "novel-writer");
}

/** 把预设两个文件落地（只在目标不存在时落地，不覆盖用户修改）。 */
async function installPreset() {
  const dest = targetDir();
  await mkdir(dest, { recursive: true });
  for (const f of ["agent.cordis.yml", "preset.yml"]) {
    try {
      await copyFile(join(SOURCE_DIR, f), join(dest, f), constants.COPYFILE_EXCL);
    } catch (err) {
      if (err.code === "EEXIST") {
        continue; // 目标已存在：跳过，绝不覆盖用户本机改过的预设。
      }
      throw err;
    }
  }
}

function apply(ctx) {
  ctx.effect(() => {
    installPreset().catch((err) => {
      console.error("[novel-writer] 预设落地失败：", err);
    });
  });
}

export { apply, name };
