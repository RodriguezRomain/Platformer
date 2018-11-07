package com.isartdigital.game.pooling;
import com.isartdigital.game.levelDesign.LevelData;

/**
 * @author Romain Rodriguez
 */
interface IPoolable 
{
  public function init(pObject:LevelData): Void;
  public function dispose(): Void;
}