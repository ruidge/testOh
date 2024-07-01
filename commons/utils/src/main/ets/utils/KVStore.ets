import { common } from '@kit.AbilityKit';
import { distributedKVStore } from '@kit.ArkData';


const bundleName = 'com.hello'
const storeId = 'hello'


const optionsSingle: distributedKVStore.Options = {
  createIfMissing: true,
  encrypt: false,
  backup: false,
  autoSync: false,
  // kvStoreType不填时，默认创建多设备协同数据库
  kvStoreType: distributedKVStore.KVStoreType.SINGLE_VERSION,
  // 多设备协同数据库：kvStoreType: distributedKVStore.KVStoreType.DEVICE_COLLABORATION,
  securityLevel: distributedKVStore.SecurityLevel.S1
};

export class KVStore {
  private kvManager?: distributedKVStore.KVManager;
  private context = getContext(this) as common.UIAbilityContext;
  private static instance: KVStore;

  constructor() {
    this.initKVManager();
  }

  public static getInstance(): KVStore {
    if (!KVStore.instance) {
      KVStore.instance = new KVStore();
    }
    return KVStore.instance;
  }

  initKVManager(): void {
    const config: distributedKVStore.KVManagerConfig = {
      context: this.context,
      bundleName: bundleName
    };
    this.kvManager = distributedKVStore.createKVManager(config)
  }

  async getStore(): Promise<distributedKVStore.SingleKVStore> {
    if (!this.kvManager) {
      this.initKVManager()
    }
    return this.kvManager!.getKVStore<distributedKVStore.SingleKVStore>(storeId, optionsSingle)
  }

  async setValue<T>(key: string, value: T): Promise<void> {
    this.getStore().then(
      (store: distributedKVStore.SingleKVStore) => {
        store.put(key, JSON.stringify(value))
      }
    );
  }

  async getValue<T>(key: string): Promise<T | null> {
    return this.getStore().then(
      (store: distributedKVStore.SingleKVStore) => {
        return store.get(key).then((res: boolean | string | number | Uint8Array) => {
          let value: T | null = null;
          if (res) {
            value = JSON.parse(res as string) as T;
          }
          return value;
        })
      }
    );
  }

  // async getValue<T>(key: string): Promise<T | null> {
  //   return new Promise((resolve, reject) => {
  //     this.getStore().then(
  //       (store: distributedKVStore.SingleKVStore) => {
  //         store.get(key).then((res: boolean | string | number | Uint8Array) => {
  //           let value: T | null = null;
  //           if (res) {
  //             value = JSON.parse(res as string) as T;
  //           }
  //           resolve(value);
  //         }).catch(() => {
  //           reject()
  //         })
  //       }
  //     ).catch(() => {
  //       reject()
  //     });
  //   });
  // }

  async deleteValue(key: string): Promise<void> {
    this.getStore().then(
      (store: distributedKVStore.SingleKVStore) => {
        store.delete(key)
      }
    );
  }
}